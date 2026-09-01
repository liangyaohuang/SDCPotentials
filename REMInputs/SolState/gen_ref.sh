#!/bin/bash

cgderiv \
  --top system.data \
  --traj "CG.lammpstrj" \
  --cut 15.5 \
  --names H2O,CO2 \
  --pair model=BSpline,type=H2O:CO2,min=2.8,max=15.0,resolution=0.05,order=6 \
  --save 'model_ref' \
  --verbose 1
