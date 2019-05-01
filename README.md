# OWC-test
Tests the OWC issue in ames.hoon before the +qeu fix on the +puq queue

```
  ~rovnys-ricfer dixit: "constructing a three-element packet queue,
                         getting Ames to ack a packet, and then seeing
                         if we can confirm downstream OWC."
```
  from: https://github.com/urbit/arvo/pull/1128#pullrequestreview-220842572

  The procedure is to try to clogg the +puq queue on ames.hoon by
  sending as many %pokes as we can. In order to confirm that napping
  the queue results in package(s) not being acked, we would return the
  data in the poke (just an @) and confirm that we get the same value back

Work in progress:

```
[...] using the pH testing framework, which virtualizes a whole Arvo inside Arvo, 
rather than our usual unit test framework. 

See the apps :ph, :aqua, and :aqua-ames for more details
```
