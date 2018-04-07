## Dai bin

```
contract Bin = {
  version: 1.0
  lib: rainbreak/coins
  address: {
    mainnet: ???
    kovan: ???
  }
  desc: "Mult-collateral dai"
}

type Ilk {
  spot: Int
  rate: Int
  line: Float
  art: Float
  gem: Address
  flip: Address
}

type Urn {
  ilk: Int
  guy: Address
  ink: Float
  art: Float
}

form
 - create ilk

file
 - update ilk

fuss
 - set ilk flipper

frob
 - update urn (ink & art)

bump
 - public lock

calm - ilk debt ceiling not exceeded
cool - debt has decreased
safe - cdp is not risky
nice - risk has decreased

spot = tag / (par . mat)
