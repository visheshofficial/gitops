#!/bin/sh
set -x

kind create cluster \
  --wait 120s \
  --config kargo-quuickstart.yaml