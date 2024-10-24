## added in inbound and outbound rule network setting -  9701-9708 port of node running inside network

give proper permission to file 
in script folder
find . -type f -exec chmod 755 {} \;

## ./manage start 4.194.26.38 WEB_SERVER_HOST_PORT=80 - this work but ledger browser not able to access

## ./manage start 4.194.26.38 -- this works able to check ledger
## ./manage start 20.205.160.7 -- this works able to check ledger




<!-- ============= API of ledger ========= -->

 - @ROUTES.get("/ledger/{ledger_name}/{txn_ident}")
 - @ROUTES.get("/genesis")
 - @ROUTES.post("/register")
 - @ROUTES.get("/ledger/{ledger_name}/text")
 - @ROUTES.get("/ledger/{ledger_name}")
 - @ROUTES.get("/status/text")
 - @ROUTES.get("/status")
 - @ROUTES.get("/browse/{ledger_ident:.*}")
 - @ROUTES.get("/")

  seed = body.get("seed")
          did = body.get("did")
          verkey = body.get("verkey")
          alias = body.get("alias")
          role = body.get("role", "ENDORSER")
          if role == "TRUST_ANCHOR":
              role = "ENDORSER"


### Register api

    request: 
    api: http://localhost:9000/register
    headers: 
      VALID_CLIENT_ID = "tgnet-auth"
      VALID_CLIENT_SECRET = "diruyf$%6t7834hduwye63"
    body: {
      "seed":"12345678901234567890123456789012",
    "alias":"ram",
    "role":""
    }

    respose: {
      "did": "6sYe1y3zXhmyrBkgHgAgaq",
      "message": "Decentralize Identity Created!",
      "seed": "12345678901234567890123456789012",
      "success": true,
      "verkey": "4CcKDtU1JNGi8U4D8Rv9CHzfmF7xzaxEAPFA54eQjRHF"
    }

Type: NYM
Alias: ram
Nym: 6sYe1y3zXhmyrBkgHgAgaq
Role: (none)
Verkey: 4CcKDtU1JNGi8U4D8Rv9CHzfmF7xzaxEAPFA54eQjRHF


---------
{
  "seed":"12345678901234567890123456789034",
 "alias":"Sita",
 "role":"ENDORSER"
}

{
  "did": "HVNuF31WYb3fRn8ArTtuoS",
  "message": "Decentralize Identity Created!",
  "seed": "12345678901234567890123456789034",
  "success": true,
  "verkey": "9zFyv3Mzz983obF75rrDctbYqatsQUFohLt3LUqcEftZ"
}

Type: NYM
Alias: Sita
Nym: HVNuF31WYb3fRn8ArTtuoS
Role: ENDORSER
Verkey: 9zFyv3Mzz983obF75rrDctbYqatsQUFohLt3LUqcEftZ


### Steps to setup network on hardware

- clone repo
  $ git clone https://github.com/tgrid-usa/tgrid-network.git
- cd tgrid-network

## Option 1 - build image from source code

- $ ./manage build 

## Option 2 - Download image from trustgrid container registry

- login into azure container registry

    $ docker login trustgridnew.azurecr.io      
    Username: trustgridnew
    Password: 
    >> Login Succeeded
    
- pull image and check tgrid-network with latest tag is downloaded or not 
  
    $ docker pull trustgridnew.azurecr.io/tgrid-network:latest
    $ docker images

### ------ comman steps -----------

- cd tgrid-network
- $ ./manage start public_ip_address

- check ledger on https://public_ip_address
  if its showing 4 node and network details, then setup done.

- Try issuing DID using api or curl
    
      request: 
        api: http://localhost:9000/register
        headers: 
          VALID_CLIENT_ID = "tgnet-auth"
          VALID_CLIENT_SECRET = "diruyf$%6t7834hduwye63"
        body: {
          "seed":"12345678901234567890123456789012",
        "alias":"ram",
        "role":""
        }

