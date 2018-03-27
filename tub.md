# Tub

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

type CupAction {
  id:  Int index
  lad: Address index
  ink: Float
  art: Float
  ire: Float
  act: Act
  arg: String
  block: Int
  time: Datetime
  tx: String
}

type Gov {
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

type Price {
  pep: Float
  pip: Float
  per: Float
  block: Int
  time: Datetime
  tx: String
}

enum Act {
  open
  join
  exit
  lock
  free
  draw
  wipe
  shut
  bite
}

event NewBlock {
  insert Price {
    pip:   Tub.pip
    pep:   Tub.pep
    per:   Tub.per
    block: event.blockNumber
    tx:    event.transactionHash
  }
}

event LogNewCup {
  insert CupAction {
    id:    event.cup
    lad:   event.lad
    art:   0
    ink:   0
    act:   'open'
    arg:   null
    block: event.blockNumber
    tx:    event.transactionHash
  }
}

event LogNote([
  sig: "give(bytes32,address)",
  sig: "lock(bytes32,uint256)",
  sig: "free(bytes32,uint256)",
  sig: "draw(bytes32,uint256)",
  sig: "wipe(bytes32,uint256)",
  sig: "bite(bytes32)",
  sig: "shut(bytes32)"
]) {
  state cup = Tub.cups[event.foo]
  insert CupAction {
    id: event.foo
    lad: cup.lad
    art: cup.art
    ink: cup.ink
    ire: cup.ire
    block: event.blockNumber
}

event LogNote(sig: "mold(bytes32,uint256)") {
  insert Gov {
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

def function cupHistory(cup: id) {
  SQL
}

def view cups {
  SQL
}

view Cup {
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
```


### GraphQL

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
