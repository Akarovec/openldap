#!/usr/bin/env just --justfile

build:
  docker build --platform linux/x86_64 -t maxname/openldap:latest openldap