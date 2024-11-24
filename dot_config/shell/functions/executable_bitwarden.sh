#!/bin/sh

__bitwarden_unlock() {
  BW_SESSION=$(bw unlock --raw "$1")
  export BW_SESSION
}
