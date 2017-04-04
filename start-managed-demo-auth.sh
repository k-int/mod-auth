#!/usr/bin/env bash

storage=${1:-"external"}
okapi_proxy_address=${2:-http://localhost:9130}
tenant_id=${3:-demo_tenant}

create_environment_variable() {
  environment_value_json_file=${1:-}

  environment_json=$(cat ${environment_value_json_file})

  curl -w '\n' -X POST -D -   \
     -H "Content-type: application/json"   \
     -d "${environment_json}" \
     "${okapi_proxy_address}/_/env"
}

echo "Building Auth Token Module"
cd authtoken_module

mvn package -q -Dmaven.test.skip=true || exit 1

cd ..

echo "Check if Okapi is contactable"
curl -w '\n' -X GET -D -   \
     "${okapi_proxy_address}/_/env" || exit 1

./create-tenant.sh

./create-admin-user.sh

echo "Running Auth Token module"
cd authtoken_module

../okapi-registration/managed-deployment/register.sh \
  ${okapi_proxy_address} \
  ${tenant_id} \
  DeploymentDescriptor.json

cd ..
