UPDATE fuss.bid
SET dealt = true
WHERE fuss.bid.id = ${event.id};
AND fuss.bid.mom = ${event.mom}

