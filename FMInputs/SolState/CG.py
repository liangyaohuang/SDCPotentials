from mscg import *


AA_traj = Trajectory('../dumphydrate.lammpstrj', fmt='lammpstrj')
AA_traj.read_frame()
AA_traj.x.shape

from mscg.cli import cgmap
cgmap.main(map='map.yaml', traj='../dumphydrate.lammpstrj', out='CG.lammpstrj')

CG_traj = Trajectory('CG.lammpstrj', fmt='lammpstrj')
CG_traj.read_frame()
CG_traj.x.shape


from mscg.cli import cgfm

cgfm.main(
    top     = "cg.top",
    traj    = "CG.lammpstrj",
    cut     = 10.5,
    pair    = ['model=BSpline,type=H2O:CO2,min=2.5,max=10.5,resolution=0.1,order=6'],
)

from mscg.cli import cgdump

cgdump.main(
    file = "result.p",
    dump = ['Pair_H2O-CO2,0.005,12.5,0.005,L2']
)

