#!/bin/bash

kill -9 `lsof -i :32693` 2> /dev/null

echo "All elixir instances stopped"
