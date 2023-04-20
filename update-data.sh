#!/bin/bash

tickers=$(grep "ticker: " content/_index.md | cut -d" " -f6)

for t in $tickers; do
  google_t=$(echo "$t" | awk -F: '{ print $2 ":" $1 }')
  price=$(curl -s "https://www.google.com/finance/quote/${google_t}" -L | grep -Eo 'data-last-price="([^"]+)' | cut -d '"' -f 2)
  if [ "$price" == "null" ]; then echo "Got wrong price for ticker ${t}, exiting..."; exit 1; fi
  line=$(($(grep -n "${t}" content/_index.md |  cut -d: -f1) + 3))
  echo "Ticker ${t} is currently \$${price}"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "${line}s/.*/    currentprice: ${price}/" content/_index.md
  else
    sed -i "${line}s/.*/    currentprice: ${price}/" content/_index.md
  fi
done
