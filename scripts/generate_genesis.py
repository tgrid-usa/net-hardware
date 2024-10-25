import json
import sys
import os

def create_genesis_files(node_num, ip=None, ips=None):
    # Basic node information
    node_base_port = 9700
    client_base_port = 9700

    # Node data template
    def create_node_data(i, ip_addr):
        return {
            "alias": f"Node{i}",
            "client_ip": ip_addr,
            "client_port": client_base_port + (2 * i - 1),
            "node_ip": ip_addr,
            "node_port": node_base_port + (2 * i),
            "services": ["VALIDATOR"]
        }

    # Create pool transactions
    pool_txns = []
    domain_txns = []

    # Use localhost if no IP provided
    node_ips = ips.split(',') if ips else [ip] * 4 if ip else ['127.0.0.1'] * 4

    # Generate transactions for the specific node
    node_ip = node_ips[node_num - 1] if node_num <= len(node_ips) else '127.0.0.1'
    node_data = create_node_data(node_num, node_ip)

    # Create genesis files
    with open("/home/indy/ledger/pool_transactions_genesis", "w") as f:
        json.dump(node_data, f, indent=2)

    # Create domain genesis with initial trustee
    trustee = {
        "ver": 1,
        "txn": {
            "type": "1",
            "data": {
                "dest": "V4SGRU86Z58d6TV7PBUe6f",
                "role": "0",
                "alias": "Trustee1",
                "verkey": "GJ1SzoWzavQYfNL9XkaJdrQejfztN4XqdsiV4ct3LXKL"
            }
        }
    }

    with open("/home/indy/ledger/domain_transactions_genesis", "w") as f:
        json.dump(trustee, f, indent=2)

if __name__ == "__main__":
    node_num = int(os.getenv('NODE_NUM', '1'))
    ip = os.getenv('IP')
    ips = os.getenv('IPS')
    create_genesis_files(node_num, ip, ips)
 