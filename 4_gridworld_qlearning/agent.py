import abc
import random

import numpy as np
import util


class Agent(abc.ABC):
    @abc.abstractmethod
    def getAction(self, state):
        """
        For the given state, get the agent's chosen
        action.  The agent knows the legal actions
        """
        ...

    @abc.abstractmethod
    def getValue(self, state):
        """
        Get the value of the state.
        """
        ...

    @abc.abstractmethod
    def getQValue(self, state, action):
        """
        Get the q-value of the state action pair.
        """
        ...

    @abc.abstractmethod
    def getPolicy(self, state):
        """
        Get the policy recommendation for the state.

        May or may not be the same as "getAction".
        """
        ...

    @abc.abstractmethod
    def update(self, state, action, nextState, reward):
        """
        Update the internal state of a learning agent
        according to the (state, action, nextState)
        transistion and the given reward.
        """
        ...

    @abc.abstractmethod
    def reset(self):
        """
        called to reset the agent at the beginning of an episode
        """


class RandomAgent(Agent):
    """
    Clueless random agent, used only for testing.
    """

    def __init__(self, actionFunction):
        self.actionFunction = actionFunction

    def getAction(self, state):
        return random.choice(self.actionFunction(state))

    def getValue(self, state):
        return 0.0

    def getQValue(self, state, action):
        return 0.0

    def getPolicy(self, state):
        return "random"

    def update(self, state, action, nextState, reward):
        pass


################################################################################
# Exercise 2


class ValueIterationAgent(Agent):
    def __init__(self, mdp, discount=0.9, iterations=100):
        """
        Your value iteration agent should take an mdp on
        construction, run the indicated number of iterations
        and then act according to the resulting policy.
        """
        self.mdp = mdp
        self.discount = discount
        self.iterations = iterations

        states = self.mdp.getStates()
        number_states = len(states)

        self.V = {s: 0 for s in states}

        for i in range(iterations):
            newV = {}
            for s in states:
                actions = self.mdp.getPossibleActions(s)
                if len(actions) < 1:
                    newV[s] = 0.0
                else:
                    newV[s] = np.max(
                        [
                            self.mdp.getReward(s, a, None)
                            + self.discount
                            * np.sum(
                                [
                                    prob * self.V[sp]
                                    for sp, prob in self.mdp.getTransitionStatesAndProbs(
                                        s, a
                                    )
                                ]
                            )
                            for a in actions
                        ]
                    )
            self.V = newV

    def getValue(self, state):
        """
        Look up the value of the state (after the indicated
        number of value iteration passes).
        """
        return self.V[state]

    def getQValue(self, state, action):
        """
        Look up the q-value of the state action pair
        (after the indicated number of value iteration
        passes).  Note that value iteration does not
        necessarily create this quantity and you may have
        to derive it on the fly.
        """
        # get all successor states and probabilities and evaluate value of these states
        return self.mdp.getReward(state, action, None) + self.discount * np.sum(
            [
                self.V[sp] * prob
                for sp, prob in self.mdp.getTransitionStatesAndProbs(state, action)
            ]
        )

    def getPolicy(self, state):
        """
        Look up the policy's recommendation for the state
        (after the indicated number of value iteration passes).
        """
        # do greedy on Q
        actions = self.mdp.getPossibleActions(state)
        if len(actions) < 1:
            return None
        else:
            qValues = [self.getQValue(state, a) for a in actions]
            action_index = np.argmax(qValues)
            return actions[action_index]

    def getAction(self, state):
        """
        Return the action recommended by the policy.
        """
        return self.getPolicy(state)

    def update(self, state, action, nextState, reward):
        """
        Not used for value iteration agents!
        """

        pass

    def reset(self):
        pass


################################################################################
# Exercise 4


class QLearningAgent(Agent):
    def __init__(self, actionFunction, discount=0.9, learningRate=0.1, epsilon=0.2):
        """
        A Q-Learning agent gets nothing about the mdp on
        construction other than a function mapping states to actions.
        The other parameters govern its exploration
        strategy and learning rate.
        """
        self.setLearningRate(learningRate)
        self.setEpsilon(epsilon)
        self.setDiscount(discount)
        self.actionFunction = actionFunction

        self.Q: dict[tuple[any, any] : float] = {}

    # THESE NEXT METHODS ARE NEEDED TO WIRE YOUR AGENT UP TO THE CRAWLER GUI

    def setLearningRate(self, learningRate):
        self.learningRate = learningRate

    def setEpsilon(self, epsilon):
        self.epsilon = epsilon

    def setDiscount(self, discount):
        self.discount = discount

    # GENERAL RL AGENT METHODS

    def getValue(self, state):
        """
        Look up the current value of the state.
        """
        possible_actions = self.actionFunction(state)
        if len(possible_actions) < 1:
            return 0

        return max([self.getQValue(state, a) for a in possible_actions])

    def getQValue(self, state, action):
        """
        Look up the current q-value of the state action pair.
        """
        return self.Q.setdefault(
            (state, action), 0.0
        )  # concise implementation to initialize entry to 0

    def getPolicy(self, state):
        """
        Look up the current recommendation for the state.
        """
        # do greedy on Q
        possible_actions = self.actionFunction(state)

        if len(possible_actions) < 1:
            return None

        qValues = [self.getQValue(state, a) for a in possible_actions]
        action_index = np.argmax(qValues)
        return possible_actions[action_index]

    def getAction(self, state):
        """
        Choose an action: this will require that your agent balance
        exploration and exploitation as appropriate.
        """
        possible_actions = self.actionFunction(state)
        if len(possible_actions) < 1:
            return None

        # epsilon case, select random action
        if random.random() < self.epsilon:
            return random.choice(possible_actions)

        # policy case
        return self.getPolicy(state)

    def update(self, state, action, nextState, reward):
        """
        Update parameters in response to the observed transition.
        """
        current_qvalue = self.getQValue(state, action)
        assert current_qvalue is not None
        possible_action_values = [
            self.getQValue(nextState, a) for a in self.actionFunction(nextState)
        ]

        if len(possible_action_values) < 1:
            self.Q[(state, action)] = current_qvalue + self.learningRate * (
            reward - current_qvalue
            )
            return

        self.Q[(state, action)] = current_qvalue + self.learningRate * (
            reward + self.discount * max(possible_action_values) - current_qvalue
        )

    def reset(self):
        """
        called to reset the agent at the beginning of an episode
        """

        return
