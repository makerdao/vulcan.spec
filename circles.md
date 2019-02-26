# Circles

```
type circles.Node {
  id:  Int      # Node ID
  guy: Address  # User
  gem: Token    # Circles Token
  val: Boolean  # is validator
}

type circles.Edge {
  src:   Node     # from node
  dst:   Node     # to node
  limit: Int      # transaction value limit
  value: Int      # total transaction value
  time:  Datetime # last touched
}

type circles.Token {
  node:  Node      # owner
  time:  Datetime  # last touched
  bal:   Float     # balance
}

allGems(): [Address]
allUsers(): [Address]

Route(from: Node, to: Node) {
  nodes {
    id: Int
  }
  edges {
    src: Address
    dst: Address
  }
}

{(a, b), (b, c), (c, d), (d, e)}

(user:Node) - [:TRANSACTIONS] -> (user:Node)
(user:Node) - [transfer:TRANSFER] -> (user:Node)
```
