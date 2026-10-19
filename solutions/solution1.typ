= 1 Optimal Policy - small examples

$
gamma = 0 &: pi_"left" &&= 1 \
gamma = 0.9 &: pi_"right" &&approx 9.47 \
gamma = 0.5 &: pi_"left" | pi_"right" &&= 1.overline(3)
$

== Left

=== $gamma =  0$ :
$
G_t &= R_(t+1) + 0 \
&= 1
$

=== $gamma =  0.9$ :
$
G_t &= R_(t+1) + gamma R_(t+2) + gamma^2 R_(t+3) + gamma^3 R_(t+4) + dots \
&= 1 + 0 + gamma^2 1 + 0 + dots \
&= sum_(j=0)^infinity gamma^(2j) \
&approx 1.5
$

=== $gamma =  0,5$ :
$
G_t &= sum_(j=0)^infinity gamma^(2j) \
&= 1.overline(3)
$
== Right

=== $gamma =  0$ :
$
G_t &= R_(t+1) + 0 \
&= 0
$

=== $gamma =  0.9$ :
$
G_t &= R_(t+1) + gamma R_(t+2) + gamma^2 R_(t+3) + gamma^3 R_(t+4) + dots \
&= 0 + gamma 2 + 0 + gamma^3 2 + dots \
&= sum_(j=0)^infinity gamma^(2j + 1) 2 \
&approx 9.47
$
=== $gamma =  0.5$ :
$
G_t &= sum_(j=0)^infinity gamma^(2j + 1) 2 \
&= 1.overline(3)
$

