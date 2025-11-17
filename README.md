# Design Flow for a PI-Controller ASIC Using HLS and LibreLane

This repository accompanies the paper **“Design of a PI-controller ASIC for a Multilevel Converter using High-Level Synthesis and LibreLane”**, providing a structured and reproducible implementation of the complete design flow.  
The repository is organized according to the four main stages of the methodology presented in the paper, from high-level algorithm specification to ASIC-ready layout generation.

The goal is to enable full replicability of the results and to serve as a reference for researchers and developers working on high-level digital control design, fixed-point arithmetic exploration, HLS methodologies, and open-source ASIC flows.

---

## Methodology Overview

The design flow follows the four-step process illustrated below:

<p align="center">
  <img src="Flow_Diagram.jpg" width="250">
</p>

Each block in this diagram corresponds to a folder in this repository, containing the files, configurations, and detailed READMEs necessary to reproduce each phase.

---

## Tools and Versions Used

The following tools were used in each stage of the design flow to ensure consistent and reproducible results:

### **Step 1 – Functional Level Algorithm Specification**
- **PLECS Standalone 4.8.10**  
- **MATLAB R2023b**

---

### **Step 2 – Fixed-Point Exploration**
- **MATLAB R2023b with Simulink**  
- **PLECS Blockset 4.8.10**  

---

### **Step 3 – High-Level Synthesis**
- **Vitis HLS 2024.1** (ap_fixed library)  
- **Bambu HLS 2024.10** (Algorithmic C Datatypes – ac_types)

---

### **Step 4 – ASIC Design Flow**
- **LibreLane 2.4.0**  
  (OpenLane-based flow using the **SKY130** PDK)



