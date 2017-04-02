#!/usr/bin/env bash

tenant_id=${1:-demo_tenant}

credentials_json=$(cat ./admin-credentials.json)

credentials_json="${credentials_json/tenantidhere/$tenant_id}"

echo "Creating admin user"
curl -w '\n' -X POST -D - \
     -H "Content-type: application/json" \
     -H "X-Okapi-Tenant: ${tenant_id}" \
     -d "${credentials_json}" \
     http://localhost:9130/authn/credentials

#echo "Bootstrapping admin user permissions"

