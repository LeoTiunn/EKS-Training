#!/bin/bash
set -x
time eksctl create cluster \
--name dec31 \
--version 1.21 \
--nodegroup-name standard-workers \
--node-type t2.micro \
--nodes 2 \
--nodes-min 1 \
--nodes-max 4 \
--managed 
