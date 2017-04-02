#!/usr/bin/env bash

tenant_id=${1:-demo_tenant}
okapi_proxy_address=http://localhost:9130

cd authtoken_module

../okapi-registration/managed-deployment/unregister.sh \
  "authtoken-module" \
  ${okapi_proxy_address} \
  ${tenant_id}

cd ..

cd login_module

../okapi-registration/managed-deployment/unregister.sh \
  "login-module" \
  ${okapi_proxy_address} \
  ${tenant_id}

cd ..

cd permissions_module

../okapi-registration/managed-deployment/unregister.sh \
  "permissions-module" \
  ${okapi_proxy_address} \
  ${tenant_id}

cd ..

./delete-tenant.sh

if  which python3
then
  pip3 install requests

  python3 ./okapi-setup/environment/clear-environment-variables.py

else
  echo "Install Python3 to remove environment variables from Okapi automatically"
fi
