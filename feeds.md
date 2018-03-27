# Pip Medianizer

```
contract med = {
  version: 1.0,
  src: https://github.com/makerdao/medianizer
  address: { mainnet: 0x729D19f657BD0614b4985Cf1D82531c67569197B },
  description: "Medianized price oracle used by tub.pip"
}

type Poke {
  guy: Address
  val: Decimal
  pip: Decimal
}

On event LogNote(sig: 'poke(bytes32)') => log
  insert Poke {
    guy:   log.guy
    val:   log.foo
    pip:   med.call read()
    block: log.blockNumber
    time:  log.timestamp
    tx:    log.transactionHash
  }
```
