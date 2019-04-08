::
::  ~rovnys-ricfer dixit: "constructing a three-element packet queue,
::                         getting Ames to ack a packet, and then seeing
::                         if we can confirm downstream OWC."
::
::  from: https://github.com/urbit/arvo/pull/1128#pullrequestreview-220842572
::
::  The procedure is to try to clogg the +puq queue on ames.hoon by
::  sending as many %pokes as we can. In order to confirm that napping
::  the queue results in package(s) not being acked, we would return the
::  data in the poke (just an @) and confirm that we get the same value back
::
/?    310
=>  |%  +$  state  $:  spam=(list @)
                       drops=@
                   ==
        +$  move   (pair bone card)
        +$  card   $%  [%peer wire dock path]
                       [%pull wire dock ~]
                       [%poke wire dock poke-data]
                       [%wait wire p=@da]
                   ==
        +$  poke-data  $%  @p
                           sms
                       ==
        +$  sms        [?(%ack %req) @]
        +$  ames-data  ::  When an app (or a vane) wishes to send a packet to
                       ::  another ship, it must send a %wont card
                       ::
                       [%wont p=sock q=path r=*]
        ::
    --
|_  [bol=bowl:gall state]
::
++  this  .
::
++  prep
  |=  old=(unit state)
  ^-  (quip move _this)
  [~ init]
::
++  init
  ^-  _this
  this(spam (gulf 1 10.000))
::
::  poking the app with a list of ship(s) will send 10.0000 pokes
::  to the first ship in the list
::
::    16:35 -> (there is a mark for a list of ships but no mark for ship...)
::    16:36 -> (there is, is called urbit :)
::
++  poke-urbit
  |=  ship=@p
  ^-  (quip move _this)
  ~&  [ship spam+(lent spam)]
  [(thousand-pokes ship) this]
::
::  poking the app with a
::
++  poke-ack
  |=  req=@
  ^-  (quip move _this)
  :: ~&  req+[req spam]
  ?~  spam  ~&("empty queue..." [~ init])
  :-  ~
  ?:  =((lent spam) 1)
    ~&  "drops: {(scow %u drops)} out of 10.000"
    init
  ?:  =(i.spam req)  this(spam t.spam)
  :: ~&  "Package [{(scow %u i.spam)}] dropped..."
  this(spam t.spam, drops +(drops))
::
++  poke-req
  |=  req=@
  ^-  (quip move _this)
  [[ost.bol %poke /ack [src.bol %owc] [%ack req]]~ this]
::
++  thousand-pokes
  |=  ship=@p
  ^-  (list move)
  %+  turn  spam
  |=  ping=@
  ^-  move
  [ost.bol %poke /spam [ship %owc] [%req ping]]
--
