#!/bin/bash

# Install required packages
sudo dnf install -y golang

# Set up Go environment
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Clone ShortURL repository
git clone https://github.com/GeertJohan/go.rice.git $GOPATH/src/github.com/GeertJohan/go.rice
git clone https://git.mills.io/prologic/shorturl.git $GOPATH/src/git.mills.io/prologic/shorturl

# Create go.mod file with module redirection
echo "module git.mills.io/prologic/shorturl" > $GOPATH/src/git.mills.io/prologic/shorturl/go.mod
echo "replace github.com/prologic/bitcask => git.mills.io/prologic/bitcask v0.3.10" >> $GOPATH/src/git.mills.io/prologic/shorturl/go.mod

# Navigate to ShortURL directory
cd $GOPATH/src/git.mills.io/prologic/shorturl

# Install rice package for ShortURL
go get github.com/GeertJohan/go.rice/rice
go install github.com/GeertJohan/go.rice/rice

go get git.mills.io/prologic/shorturl

# Embed assets using Go rice
sudo $GOPATH/bin/rice embed-go

# Install additional required packages
go get github.com/lithammer/shortuuid
go get git.mills.io/prologic/bitcask


# Build ShortURL
go build

# Run ShortURL
./shorturl &
sleep 2

# Access ShortURL web app
echo "ShortURL web app is running at http://192.168.20.5:8000/"

# Clean up
unset GOPATH
unset PATH
