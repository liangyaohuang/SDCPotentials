# SDCPotentials: State-Dependent Composite Potentials for CO₂ Hydrate CG Modeling

This repository contains the input files, optimization scripts, tabulated pair potentials, and LAMMPS simulation setups associated with the publication:

> **Multicomponent Crystallization via Bottom-Up Coarse-Grained Modeling: CO₂ Hydrate Formation**  
> Liang-Yao Huang, Kuntal Ghosh, Shiang-Tai Lin, and Gregory A. Voth*  
> *The Journal of Physical Chemistry B* (2026)  
> DOI: [https://doi.org/10.26434/chemrxiv.15006987/v1]

---

## 📌 Overview

This project provides a complete bottom-up coarse-grained (CG) modeling workflow for simulating the crystallization, growth, and spontaneous nucleation of sI CO₂ clathrate hydrates. Both water and CO₂ are modeled as single-site representations at their respective molecular centers of mass, with water interactions described by the single-site **Bottom-Up Many-Body Projected (BUMPer)** water model.

The core innovation is a **State-Dependent Composite Potential** for the water–CO₂ cross-interaction, combining phase-specific reference potentials parameterized via Force Matching (FM) and Relative Entropy Minimization (REM) across various mixing parameters $\alpha \in [0.0, 1.0]$.

> **Note**: All tabulated pair potentials provided in this repository correspond to a temperature setting of **270 K**. The underlying all-atom (AA) reference force fields are **TIP4P/Ice** for water and **EPM2** for CO₂.
---

## 📁 Repository Structure

```text
SDCPotentials/
├── FMInputs/                       # Force Matching (FM) mapping and topology setups
│   ├── HydState/                   # Hydrate crystal state FM inputs
│   ├── PureCO2/                    # Pure liquid/fluid CO2 FM inputs
│   └── SolState/                   # Solution liquid state FM inputs
├── REMInputs/                      # Relative Entropy Minimization (REM) optimization scripts
│   ├── HydState/                   # REM scripts & baseline models for hydrate state
│   ├── PureCO2/                    # REM scripts & baseline models for pure CO2
│   └── SolState/                   # REM scripts & baseline models for solution state
├── PairPotentials/                 # Final tabulated pair potentials for LAMMPS
│   ├── bumper_tip4pice_270.table   # BUMPer H2O–H2O potential
│   ├── Pair_CO2-CO2.table          # REM CO2–CO2 potential
│   └── alphaX.XXX/                 # State-dependent H2O–CO2 potentials (alpha = 0.0 to 1.0)
└── LMPInputs/                      # LAMMPS simulation scripts and coordinate data files
    ├── AAReference/                # All-Atom (AA) reference trajectories (Hydrate & Pure CO2)
    ├── CGGrowth/                   # CG crystal seed growth simulations
    └── CGNucleation/               # CG homogeneous nucleation simulations
```

---

## ⚙️ Prerequisites & Software Requirements

- **Molecular Dynamics Engine**: [LAMMPS](https://www.lammps.org/) (compiled with standard `MOLECULE` and `MANYBODY` packages).
- **Tabulated Potential Support**: Requires `pair_style table` with linear or spline interpolation.
- **CG Optimization & Parameterization Tools**: 
  - [OpenMSCG](https://voices.uchicago.edu/vothgroup/downloadablematerials/) (Open-Source Multiscale Coarse-Graining software package for FM and REM setups).
  - Python 3.x, NumPy, SciPy (for FM/REM data processing scripts).

---

## 🚀 How to Run LAMMPS CG Simulations

### 1. Tabulated Potential Setup in LAMMPS
In your LAMMPS input script (e.g., `LMPInputs/CGNucleation/CG_hydrate.in`), define the tabulated pair potentials using the files in `PairPotentials/`:

```lammps
units           real
atom_style      full

# Set up pair_style table (e.g., 2000 table entry points)
pair_style      table linear 2000

# Type 1: CG Water (BUMPer), Type 2: CG CO2
pair_coeff      1 1 PairPotentials/bumper_tip4pice_270.table BUMPER
pair_coeff      2 2 PairPotentials/Pair_CO2-CO2.table REM_CO2

# Water-CO2 cross-interaction using state-dependent composite potential (e.g., alpha = 0.50)
pair_coeff      1 2 PairPotentials/alpha0.50/Pair_H2O-CO2.table TABLE_KEYWORD
```

### 2. Running Example Simulations

CG Crystal Growth Simulation:
```
cd LMPInputs/CGGrowth
lmp_serial -in CG_hydrate.in
```
CG Spontaneous Nucleation Simulation:
```
cd LMPInputs/CGNucleation
lmp_serial -in CG_hydrate.in
```

---

## 📄 Citation

If you use the composite potential tables, input scripts, or methodology from this repository in your research, please cite our main paper:

```bibtex
@article{Huang2026Multicomponent,
  author    = {Huang, Liang-Yao and Ghosh, Kuntal and Lin, Shiang-Tai and Voth, Gregory A.},
  title     = {Multicomponent Crystallization via Bottom-Up Coarse-Grained Modeling: CO2 Hydrate Formation},
  journal   = {The Journal of Physical Chemistry B},
  year      = {2026},
  note      = {In Press}
}
```
Depending on the specific components utilized from this repository, please also cite the following underlying tools and models:
1. BUMPer Water Model (for water–water potential)
```bibtex
@article{Jin2021BUMPer1,
  author    = {Jin, Jun and Han, Yining and Pak, Alexander J. and Voth, Gregory A.},
  title     = {A new one-site coarse-grained model for water: Bottom-up many-body projected water (BUMPer). I. General theory and model},
  journal   = {The Journal of Chemical Physics},
  volume    = {154},
  number    = {4},
  year      = {2021},
  doi       = {10.1063/5.0027734}
}

@article{Jin2021BUMPer2,
  author    = {Jin, Jun and Pak, Alexander J. and Han, Yining and Voth, Gregory A.},
  title     = {A new one-site coarse-grained model for water: Bottom-up many-body projected water (BUMPer). II. Temperature transferability and structural properties at low temperature},
  journal   = {The Journal of Chemical Physics},
  volume    = {154},
  number    = {4},
  year      = {2021},
  doi       = {10.1063/5.0027735}
}
```
2. OpenMSCG Software Package (for FM and REM parameterizations in FMInputs/ and REMInputs/)
```bibtex
@misc{OpenMSCG,
  author       = {Voth Group, The University of Chicago},
  title        = {OpenMSCG: Open-Source Multiscale Coarse-Graining Software Package},
  howpublished = {\url{https://uchicago.github.io/openmscg/}},
  year         = {2021}
}
```

---

## 📧 Contact & Support
For questions or inquiries regarding the parameterization or simulation setups, please contact:

Liang-Yao Huang (First Author)

Prof. Gregory A. Voth (Corresponding Author): gavoth@uchicago.edu

---
