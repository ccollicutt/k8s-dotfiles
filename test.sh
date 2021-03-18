#!/usr/bin/env bash 

#docker run -it -v "${PWD}:/code" bats-with-helpers:latest /code/tests/test_install.bats
#docker run -it -v "${PWD}:/code" --entrypoint "/bin/sh" bats-with-helpers:latest -c "cd /code && ./tests/test_install.bats"

docker run -e RUN_LOCAL=true -v "${PWD}:/tmp/lint" github/super-linter
