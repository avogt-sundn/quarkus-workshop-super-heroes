#!/usr/bin/env bash
# tag::adocShell[]
export NODE_OPTIONS=--openssl-legacy-provider; 
./node_modules/.bin/ng build --configuration production --base-href "."
# end::adocShell[]

