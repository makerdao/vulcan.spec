# Tub gov

```
contract Tub = {
  version: 1.0
  lib: makerdao/sai
  address: {
    kovan:   0xa6bfc88aa5a5981a958f9bcb885fcb3db0bf941e
    mainnet: 0x448a5065aebb8e423f0896e6c5d525c040f59af3
  }
  description: "Dai 1.0 Tub"
}

type Mold {
  cap: Float
  mat: Float
  tax: Float
  fee: Float
  axe: Float
  gap: Float
  var: Float
  arg: Float
  block: Int
  time: Datetime
  tx: String
}

event LogNote(sig: "mold(bytes32,uint256)") {
  Mold.create {
    cap:   Tub.cap
    mat:   Tub.mat
    tax:   Tub.tax
    fee:   Tub.fee
    axe:   Tub.axe
    gap:   Tub.gap
    block: event.blockNumber
    tx:    event.transactionHash
    arg:   event.returnValues.bar
    var:   event.returnValues.foo
  }
}


type Query {
  allMolds(args): [Mold]
}
```
