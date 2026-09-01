#!/bin/bash

cgrem \
  --ref model_ref.p \
  --cgderiv-arg cgderiv.sh \
  --optimizer builtin,chi=0.5,t=270.00 \
  --maxiter 8 \
  --md md.inp \
  --models model.txt \
  --verbose 1
