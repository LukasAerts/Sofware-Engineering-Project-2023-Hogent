#! /bin/bash
#
# Provisioning script for rallly on trinitty

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

#------------------------------------------------------------------------------

#install and configure a postgres db for rallly 

# Install PostgreSQL
sudo dnf install -y postgresql-server postgresql-contrib

# Initialize the PostgreSQL database
sudo postgresql-setup initdb

# Start and enable PostgreSQL
systemctl enable --now postgresql 

# give default postgres user a password so we can use in the connection string later

sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"

# Update the pg_hba.conf file to give authentication permissions to my database user by replacing idnet method with md5 for all users and dbs
sed -i "s#host    all             all             127.0.0.1/32            ident#host    all             all             127.0.0.1/32            md5#g" /var/lib/pgsql/data/pg_hba.conf
sed -i "s#host    all             all             ::1/128                 ident#host    all             all             ::1/128                 md5#g" /var/lib/pgsql/data/pg_hba.conf

# Restart PostgreSQL to apply changes
systemctl restart postgresql

# Install Node.js (version 18x) and yarn

# download and add node js source  to repo
curl --silent --location https://rpm.nodesource.com/setup_18.x | bash -
# install node js
dnf install nodejs -y
# download and add yarn source to repo
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
# install yarn
dnf install yarn -y

# Install Git
dnf install git -y

# Clone Rallly repository
git clone https://github.com/lukevella/Rallly.git /home/vagrant/rallly

# Install dependencies and build production-ready code
# moves you to the correct directory where rallly got downloaded
cd /home/vagrant/rallly

# creat .env file to save your variables
cat <<EOF > /home/vagrant/rallly/.env
# A random 32-character secret key used to encrypt user sessions
SECRET_PASSWORD=abcdefghijklmnopqrstuvwxyz1234567890

# The base url where this instance is accessible, including the scheme.
NEXT_PUBLIC_BASE_URL=http://localhost:3000

# A connection string to your Postgres database
DATABASE_URL=postgres://postgres:postgres@127.0.0.1:5432/postgres
EOF

# Install dependencies
yarn --non-interactive

# generate the prisma database client, run migrations to create the database schema, seed the database with some random data
yarn db:generate && yarn db:deploy

# build dev code
yarn dev > /dev/null &

#--------------------------------------------------------------
# extra making sure rallly gets autostarted after reboot
#--------------------------------------------------------------

# Create the service file with the necessary configuration
tee /etc/systemd/system/rallly.service > /dev/null <<EOF
[Unit]
Description=Rallly application
After=network.target postgresql.service
Requires=postgresql.service

[Service]
Type=simple
WorkingDirectory=/home/vagrant/rallly
ExecStart=/usr/bin/bash -c "sudo yarn dev"
Restart=always
User=vagrant

[Install]
WantedBy=multi-user.target
EOF

# Reload the systemd configuration
systemctl daemon-reload

# Start and enable the rallly service
systemctl enable --now rallly

#------------------------------------------------------------
