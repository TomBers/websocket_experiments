#!/bin/bash
cmd="echo `tail queue`"
while true; do
  $cmd
  sleep 500
done
