#!/bin/bash

tickers=$(grep "ticker: " content/_index.md | cut -d: -f3)

for t in $tickers; do
  price=$(curl -s "https://query1.finance.yahoo.com/v7/finance/quote?symbols=${t}" | jq -r '.quoteResponse.result[0].regularMarketPrice')
  line=$(($(grep -n :${t} content/_index.md |  cut -d: -f1) + 3))
  echo "Ticker ${t} is currently \$${price}"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "${line}s/.*/    currentprice: ${price}/" content/_index.md
  else
    sed -i "${line}s/.*/    currentprice: ${price}/" content/_index.md
  fi
done
