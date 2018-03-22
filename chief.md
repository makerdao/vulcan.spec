# Chief

```
slates[sha]    => [candidate, candidate]
votes[guy]     => sha
approvals[guy] => $amount
deposits[guy]  => $amount

lock(wad)
free(wad)

etch(addresses)   create a slate
vote(slate)       move a voters weight to the specified slate

lift              hat goes to the most approvals

SELECT * FROM slates LIMIT 1;
---------------------------------
id            | 31fb53c
addresses     | [ 0x1, 0x2, 0x3 ]

SELECT * FROM votes LIMIT 1;
---------------------------------
address       | 0x4
slate_id      | 31fb53c

SELECT * FROM approvals LIMIT 1;
---------------------------------
address       | 0x4
value         | 100,000

SELECT * FROM deposits LIMIT 1;
---------------------------------
address       | 0x4
value         | 100,000
```

### Votes

```
votes[guy] => sha
```

### List - all voters

Group by sha sort by votes

```
GET /votes [
  #guy: {
    #sha: [
      #candidate: {
        votes: $amount
      },
      #candidate: {
        votes: $amount
      },
    ]
  },
  #guy: {
    #sha: [
      #candidate: {
        votes: $amount
      },
      #candidate: {
        votes: $amount
      },
    ]
  }
]
```

### Slates

```
slates[sha] => [candidate, candidate]
```

### List - all slates

Sort by total amounts

```
GET /slates [
  #sha: [
    #candidate: {
      total: $amount
    },
    #candidate: {
      total: $amount
    },
  ],
  #sha: [
    #candidate: {
      total: $amount
    },
    #candidate: {
      total: $amount
    },
  ]
]
```

### Deposits

```
deposits[guy] => $amount
```

### List - all deposits

Sort by total amount

```
GET /deposits [
  #guy: {
    total: $amount
  },
  #guy: {
    total: $amount
  }
]
```

### Show

```
GET /deposits/#guy {
  total: $amount
}
```

### Deposit Logs

Sort by timestamp

```
GET /deposits/#guy/history {
  $timestamp: {
    total: $amount
  },
  $timestamp: {
    total: $amount
  }
}
```

### Approvals - top candidates

```
approvals[candidate] => $amount
```

### List

Sort by total amount for top candidates

```
GET /approvals [
  #candidate: {
    total: $amount
  },
  #candidate: {
    total: $amount
  }
]
```

### ACTIONS

### Lock & Free

Add and remove voting stake (MKR) in exchange for IOU

```
lock(amount) =>
  deposits[msg.sender] += amount

free(amount) =>
  deposits[msg.sender] -= amount
```

### Etch - create a slate

```
etch(candidates) =>
  slates[sha] = candidates
```

### Vote - assign weight to a slate

```
vote(sha) =>
  votes[msg.sender] = sha
  slate[sha].each =>
    approvals[candidate] = (approvals[candidate] + deposits[msg.sender])
```

### Promote a top candidate to hat

```
lift(address) =>
  approvals[whom] > approvals[hat]
  hat = address
```
