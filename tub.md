# Tub

* Source: [makerdao/sai/src/tub.sol](https://github.com/makerdao/sai/blob/master/src/tub.sol)
* Mainnet: [Dec-18-2017](https://etherscan.io/address/0x448a5065aebb8e423f0896e6c5d525c040f59af3)
* Kovan: [Dec-18-2017](https://kovan.etherscan.io/address/0xa6bfc88aa5a5981a958f9bcb885fcb3db0bf941e)

### Watched Events

`LogNewCup(lad, cup)`

* open

`LogNote(sig, guy, foo, cupi, arg)`

* give
* lock
* free
* draw
* wipe
* shut
* bite

`LogNote(sig, guy, foo, var, arg)`

* mold

### Views

* cups
* cup_acts
* cup_history

### Types

```graphql
type Cup {
  act: Act!            # Most recent cup action
  art: BigFloat!       # Outstanding debt DAI
  block: Int!          # Block at most recent action
  deleted: Boolean!    # True if the cup has been shut
  id: Int!             # Unique Cup Id
  ink: BigFloat!       # Collateral PETH
  ire: BigFloat!       # Collateral less fee
  lad: String!         # Cup owner
  pip: BigFloat!       # Current USD/ETH price
  ratio: BigFloat      # Current collateralisation ratio
  bag: BigFloat        # Collateral USD
  time: Datetime!      # Timestamp of most recent action
  actions: [CupAct!]   # Cup actions
  history(tick: TickInterval): [CupTick!]  # Cup history
}

type CupAct {
  act: Act!            # Action name
  arg: String!         # Action argument
  art: BigFloat!       # Debt DAI at block
  block: Int!          # Block number
  deleted: Boolean!    # True if the cup has been shut
  id: Int!             # Cup Id
  ink: BigFloat!       # Collateral PETH at block
  lad: String!         # Cup owner
  pip: BigFloat!       # USD/ETH price at block
  ratio: BigFloat      # Collateralisation ratio at block
  bag: BigFloat        # Collateral USD at block
  time: Datetime!      # Block timestamp
  tx: String           # Transaction hash
}

type CupTick {
  tick: Datetime!
  minPip: BigFloat!
  maxPip: BigFloat!
  minBag: BigFloat
  maxBag: BigFloat
  minRatio: BigFloat
  maxRatio: BigFloat
  act: Act
  arg: String
  ink: BigFloat
  art: BigFloat
  time: Datetime
}

type Gov {
  arg: String!         # Mold argument
  axe: Int
  block: Int!          # Block number
  cap: String!
  guy: String!         # Message sender
  fee: Int
  gap: Int
  mat: Int
  tax: Int
  tx:  String          # Transaction hash
  var: String          # Mold op
}

enum Acts {
  OPEN
  GIVE
  LOCK
  FREE
  DRAW
  WIPE
  SHUT
  BITE
}

enum TickInterval {
  HOUR
  DAY
  WEEK
  MONTH
}

type Query {

  # Find a cup by ID
  #
  # Arguments
  # id: The cup ID.
  getCup(
    id: Int!,
  ): Cup

  # Perform a search across cups
  #
  # Arguments
  # first: Returns the first _n_ elements from the list.
  # last: Returns the last _n_ elements from the list.
  # before: Returns the elements in the list that come before the
  # specified cup ID.
  # after: Returns the elements in the list that come after the
  # specified cup ID.
  allCups(
    first: Int,
    last: Int,
    before: Int,
    after: Int
  ): [Cup]

  # Perform a search across cup actions
  #
  # Arguments
  # first: Returns the first _n_ elements from the list.
  # last: Returns the last _n_ elements from the list.
  # after: Returns the elements in the list that come after the
  # specified block.
  allCupActs(
    first: Int,
    last: Int,
    before: Int,
    after: Int
  ): [CupAct]
}
```
