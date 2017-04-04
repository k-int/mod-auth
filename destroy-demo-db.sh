#!/usr/bin/env bash

host=${1:-localhost}
port=${2:-5432}

executing_user=${4:-$USER}
executing_password=${5:-}

cd database-setup

./destroy-db.sh auth_demo demo_tenant_login_module auth_demo_admin ${host} ${port} ${executing_user} ${executing_password}

# Drop the tenant based role as well, because deactivation no longer calls the Tenant API
./drop-role.sh demo_tenant_login_module
./drop-role.sh demo_tenant_permissions_module

cd ..
