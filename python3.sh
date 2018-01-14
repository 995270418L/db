#!/bin/bash
mkdir /usr/local/python3
wget --no-check-certificate https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz
tar -xzvf Python-3.6.0.tgz 
cd Python-3.6.0 
./configure --prefix=/usr/local/python3 
make
make install
ln -s /usr/local/python3/bin/python3 /usr/bin/python3
ln -s /usr/local/python3/bin/pip3 /usr/bin/pip

