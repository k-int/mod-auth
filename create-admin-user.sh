#!/usr/bin/env bash

tenant_id=${1:-demo_tenant}

echo "Creating admin user"
credentials_json=$(cat ./admin-credentials.json)

credentials_json="${credentials_json/tenantidhere/$tenant_id}"

curl -w '\n' -X POST -D - \
     -H "Content-type: application/json" \
     -H "X-Okapi-Tenant: ${tenant_id}" \
     -d "${credentials_json}" \
     http://localhost:9130/authn/credentials

echo "Bootstrapping admin user permissions"

permissions_user_json=$(cat ./permission_user.json)

curl -w '\n' -X POST -D - \
     -H "Content-type: application/json" \
     -H "X-Okapi-Tenant: ${tenant_id}" \
     -d "${permissions_user_json}" \
     http://localhost:9130/perms/users
