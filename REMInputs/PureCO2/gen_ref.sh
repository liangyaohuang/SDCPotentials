#!/bin/bash

cgderiv \
  --top co2.data \
  --traj dumpco2.lammpstrj \
  --cut 15.5 \
  --names CO2 \
  --pair model=BSpline,type=CO2:CO2,min=2.5,max=15.0,resolution=0.05,order=6 \
  --save "model_ref" \
  --verbose 1
