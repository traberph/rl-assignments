#import "template/header.typ": submission

#show: submission.with(
  exerciseNumber: 4
)

#set heading(numbering: "1.1.a)")
= Hands-on the Gridworld
== Q-Learning

===
We saw both lower and higher values than in the comparison Figure. This can be due to run-to-run randomness.
To reduce this and get reliably closer to the optimal policy, the noise parameter should be reduced.
#figure(
  image("assets/04/2-1-a.png", height: 50%),
  caption: [
    Value function of q-learning on MazeGrid
  ],
)
===
The policy is pointing to the left towards the reward of 1.
Because it takes a lot of random epsilon- or noise-actions from the start to reach the higher "10" reward even once. 
If that unlikely case occurs, the reward can propagate to the other states and will dominate the policy.

#figure(
  image("assets/04/2-1-b.png", width: 80%),
  caption: [
    qValue function on BridgeGrid
  ],
)
===
Average returns from start state: $-25.56$ \
Value function of start state: $3.78$

The formula for the value only considers the optimal (in terms of reachable q values) next action and does not include the possibility of random epsilon-actions and their rewards. \
Since random actions can result in highly negative rewards on CliffGrid, the average return is lower than the start state's value.

#figure(
  image("assets/04/2-1-c.png", width: 80%),
  caption: [
    Value function on CliffGrid
  ],
)

===
\-
