#!/bin/bash
set -e

# Create ledger directory if it doesn't exist
mkdir -p /home/indy/ledger

# Check if genesis files already exist
if [ ! -f /home/indy/ledger/pool_transactions_genesis ]; then
    echo "Ledger does not exist - Creating..."
    python3 /home/indy/scripts/generate_genesis.py
else
    echo "Genesis files already exist"
fi
 