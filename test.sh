#!/usr/bin/env bash 

docker run -it -v "${PWD}:/code" bats-with-helpers:latest /code/tests/test_install.bats