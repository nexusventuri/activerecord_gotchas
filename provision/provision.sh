#!/bin/bash

set -e

# postgres repo
echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/postgres.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

apt-get update -y > /dev/null
apt-get -y install \
  postgresql-server-dev-all  \
  osm2pgsql \
  postgresql-client \
  ruby2.4 \
  ruby2.4-dev \

usermod -a -G admin vagrant
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

if ! grep -q 'PGHOST=localhost' '/etc/environment'; then
  echo 'PGHOST=localhost' >> '/etc/environment'
  echo 'PGUSER=carwow' >> '/etc/environment'
  echo 'PGPASSWORD=carwow' >> '/etc/environment'
fi
