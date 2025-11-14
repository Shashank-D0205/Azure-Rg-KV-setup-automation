#!/bin/bash
log() {
  echo -e "\n➡️  $1\n"
}

error() {
  echo -e "\n❌  $1\n"
  exit 1
}
