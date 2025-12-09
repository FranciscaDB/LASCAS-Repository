# Reference Model Files

This folder contains the files used to obtain the **reference model**.

## PLECS
The `PLECs/` folder includes the **original system model**. From this model, a reference dataset of **inputs and outputs** is exported (initially as a `.mat` file). This dataset is then used to derive an **equivalent MATLAB model**.

## MATLAB
The `MATLAB/` folder contains the scripts created to **test and validate the MATLAB model**.

For convenience, the reference data generated in PLECS was also exported/converted to **CSV format**. Using this CSV reference, a **testbench** is executed to compare the MATLAB model outputs against the **PLECS reference outputs**, enabling a direct sample-by-sample verification.