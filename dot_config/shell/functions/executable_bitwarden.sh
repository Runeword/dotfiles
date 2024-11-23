#!/bin/sh

__bu() {
  BW_SESSION=$(bw unlock --raw "$1")
  export BW_SESSION
}
