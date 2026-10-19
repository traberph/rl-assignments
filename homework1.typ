= 1 Optimal Policy - small examples

Optimal policies:


== Left

=== $gamma =  0$ :
$
G_t = R_(t+1) + 0 = 1
$

=== $gamma =  0.9$ :
$
G_t = R_(t+1) + gamma R_(t+2) + gamma^2 R_(t+3) + gamma^3 R_(t+4) + dots \
G_t = 1 + 0 + gamma^2 1 + 0 + dots \
G_t = sum_(j=0)^infinity gamma^(2j)
$

=== $gamma =  0,5$ :
$
G_t = sum_(j=0)^infinity gamma^(2j)
$
== Right

=== $gamma =  0$ :
$
G_t = R_(t+1) + 0 = 1
$

=== $gamma =  0.9$ :
$
G_t = R_(t+1) + gamma R_(t+2) + gamma^2 R_(t+3) + gamma^3 R_(t+4) + dots \
G_t = 0 + gamma 2 + 0 + gamma^3 2 + dots \
G_t = sum_(j=0)^infinity gamma^(2j + 1) 2
$
=== $gamma =  0.5$ :
$
G_t = sum_(j=0)^infinity gamma^(2j + 1) 2
$

