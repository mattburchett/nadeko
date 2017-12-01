#!/bin/bash
if [ -z "$1" ]; then
  echo "You need to specify a version."
  exit
else
  docker build -t mattburchett/nadeko-$1 .
fi
