# Hybrid-SSO-SMA-Shaded-PV-Switch-Matrix

This repository implements a **Hybrid Salp Swarm and Slime Mold Optimization Algorithm (Hybrid SSO-SMA)** for optimizing the switching matrix of shaded photovoltaic (PV) arrays. The goal is to dynamically reconfigure PV arrays to enhance power output under partial shading conditions.

## Features
- **Hybrid Optimization**: Combines the strengths of Salp Swarm Optimizer (SSA) and Slime Mold Algorithm (SMA).
- **Dynamic Reconfiguration**: Optimizes PV module arrangements to minimize power losses.
- **Detailed Outputs**: Provides visualizations, power enhancement calculations, and convergence analysis.

## Directory Structure
```
Mahmood-Anaam-hybrid-sso-sma-shaded-pv-switch-matrix/
├── README.md                # Project documentation
├── doc/                     # Documentation files (optional)
└── src/                     # Source code files
    ├── DisplayResultsDiaryFile.txt  # Logs simulation results
    ├── SMA.m                # Slime Mold Algorithm implementation
    ├── SSA.m                # Salp Swarm Algorithm implementation
    ├── SSSMA.m              # Hybrid SSO-SMA algorithm implementation
    ├── changearrangement.m  # Helper function for matrix rearrangement
    ├── getInfo.m            # Retrieves power metrics and configurations
    ├── initialization.m     # Initializes search agents
    ├── main.m               # Main script to run the simulation
    ├── objective_function.m # Defines the fitness function
    └── randomize_matrix_vertically.m # Randomizes matrix rows
```

## How to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/Mahmood-Anaam/hybrid-sso-sma-shaded-pv-switch-matrix.git
   ```
2. Open MATLAB and navigate to the `src/` directory.
3. Run the main script:
   ```matlab
   main.m
   ```

## Outputs
- **Optimized PV Array Configuration**: Displays the rearranged PV matrix.
- **Power Enhancement Percentage**: Calculates the improvement in power output.
- **Convergence Curve**: Shows the optimization progress.
- **Visualization**: Provides a comparison of original and optimized configurations.

