#!/bin/bash

abspath() {
  # $1 : relative filename
  if [ -d "${1%/*}" ]; then
    echo "$(cd ${1%/*}; pwd)/${1##*/}"
  fi
}

if [ "${1}" != "--source-only" ]; then
    abspath "${@}"
fi