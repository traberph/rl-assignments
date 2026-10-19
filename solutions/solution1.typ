#set heading(numbering: "1.a.1)")
= Optimal Policy - small examples

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


= Value Estimation in Grid Worlds
 ==

 #table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*k*], [*mean*], [*std*],
  ),
  [10],[0.00031],[0.00063],
  [100], [0.00345], [0.01867],
  [1000], [0.00269], [0.01233],
  [10000], [0.00231], [0.01249]

)
 ==
 $
 n>=
 ((1.96 dot sigma)/0.0004)^2
 ((1.96 dot 0.01249)/0.0004)^2
 approx
 3745.5624
 $
 ==
 $
 n>=
 ((1.96 dot sigma)/0.1)^2
 ((1.96 dot 3.7595)/0.1)^2
 approx
 5429.6561
 $


