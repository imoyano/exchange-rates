#!/bin/bash

# clean up from last time
kill -9 `lsof -i :32693` 2> /dev/null

cd xrc_api

# export DATABASE_URL='ecto://xrc_user:XRc_Us3r!23@opal8.opalstack.com/xrc_db'

MIX_ENV=dev PORT=32693 elixir --erl "-detached" -S mix phx.server
# MIX_ENV=prod PORT=32693 elixir --erl "-detached" -S mix phx.server

echo "Elixir app is running on https://exchange.m1.cl"
