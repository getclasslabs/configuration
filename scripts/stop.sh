#!/bin/bash

docker service rm $(docker service ls | grep -v NAME | awk '{print $2}')