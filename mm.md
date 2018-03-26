def contract tub = 0x01

def collection cups {
  lad: "address",
  ink: "wad",
  art: "wad",
  ire: "wad"
}

def collection gov {

}

On event [LogNewCup]
  event { block, time, 'open', null }
  state { tub.lad, 0, 0, 0 }
  insert cups event << state

On event [LogNote(sig), LogNote(sig)]
  event { block, time, foo, bar }
  lookup cup = cups[event.foo]
  state { cup.lad, cup.ink, cup.art, cup.ire }
  append cups event.time :: event.block :: event.bar as arg :: state

On each gov log event
  event { block, time, foo, bar }
  state { tub.mat, tub.tax, tub.gat, tub.fee }
  insert gov event << state
