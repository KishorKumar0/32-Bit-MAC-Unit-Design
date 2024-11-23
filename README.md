# Multiply-Accumulate (MAC) Unit Using Vedic Multiplier and DKG Adder
## 1. Project Overview
This project implements a high-performance Multiply-Accumulate (MAC) Unit using a Vedic Multiplier for fast multiplication and a DKG Adder for efficient addition. The design is developed in Verilog HDL, emphasizing modularity and scalability. It targets applications requiring real-time signal processing, such as DSPs, image processing, and AI accelerators.


## 2. Design Components
### 2.1 MAC Unit
***Accumulator<sub>out</sub>=Accumulator<sub>in</sub>+(multiplicand×multiplier)***

**Key Modules:**
  1. **Multiplication:**
    - Performed using a **Vedic Multiplier** based on the Urdhva Tiryagbhyam sutra, enabling parallel computation.
    - Efficiently scales from **2**×**2** to **32**×**32** bits.
  2. **Addition:**
    - Performed using the **DKG Adder**, a reversible logic-based design that minimizes energy loss and improves computational efficiency.
  3. **Accumulator:**
     - Accumulates the result over multiple clock cycles.
     - Reset functionality allows clearing the accumulator for new computations.

### 2.2 Vedic Multiplier
**Hierarchy of Multipliers:**
  - **2x2 Multiplier:** Implements basic bitwise AND and addition operations using half and full adders.
  - **4x4 Multiplier:** Combines four **2**×**2** multipliers and uses adders for intermediate results.
  - **8x8 Multiplier:** Combines four **4**×**4** multipliers.
  - **16x16** Multiplier: Combines four **8**×**8** multipliers.
  - **32x32** Multiplier: Combines four **16**×**16** multipliers.

**Features:**
  - **Recursive Design:** Each level is built upon the previous, making the structure modular and scalable.
  - **High Performance:** Parallelism in Vedic computation ensures fast multiplication

### 2.3 DKG Adder Using Reversible Gates
**Description:**
The Draper-Kutin-Ghose (DKG) adder is a reversible adder that:
  - Performs binary addition without information loss.
  - ses reversible gates like **Toffoli** and **Fredkin** gates for computation.
  - Conserves power, aligning with energy-efficient computation principles.
    
**Features:**
  - **Carry Propagation:** Generates carry signals using reversible logic gates.
  - **Reversibility:** Ensures all intermediate data can be reconstructed from outputs.

### 2.4 Testbench
**MAC Testbench (mac_tb):**
  - Stimulates the MAC unit with different values of **multiplicand** and **multiplier**.
  - Outputs the intermediate and final results of the accumulator.
  - Checks the functionality under **reset conditions**.


## 3. Functional Description
**Inputs:**
  - **Multiplicand:** 32-bit input operand for multiplication.
  - **Multiplier:** 32-bit input operand for multiplication.
  - **Clock:** Synchronizes operations.
  - **Reset:** Resets the accumulator to zero.

**Outputs:**
  - **Accumulator Output:** 65-bit result of the multiply-accumulate operation.


## 4. Code Organization
### 4.1. File Structure
  1. **mac.v:** Top-level module implementing the MAC unit.
  2. **vedic_2x2, vedic_4x4, vedic_8x8, vedic_16x16, vedic_32x32:** Modules for Vedic multiplication.
  3. **adder.v:** Contains reversible DKG adder implementation.
  4. **mac_tb.v:** Testbench for the MAC unit.


## 5. Applications
  1.**Digital Signal Processing (DSP):** MAC operations are central to FIR and IIR filters.
  2. **AI and ML Accelerators:** Used in convolutional and matrix-multiplication-heavy workloads.
  3. **Image Processing:** Real-time processing for filters, edge detection, etc.
  4. **Low-Power Devices:** Energy-efficient computation using reversible gates.


## 6. Advantages of the Design
  1. **Speed:** Vedic Multiplier ensures high-speed computations through parallelism.
  2. **Scalability:** Modular design supports various bit-widths.
  3. **Energy Efficiency:** Reversible gates in the DKG adder minimize power dissipation.
  4. **Reusability:** Modules can be reused for other arithmetic operations.


## Future Improvements
  1. **Hardware Implementation:** Synthesize and test on FPGA platforms like Xilinx or Intel.
  2. **Optimized Reversible Gates:** Experiment with alternate reversible gate designs for reduced ancilla usage.
  3. **Parallel MAC Units:** Extend to support parallel multiply-accumulate operations.
<!-- ![image](https://github.com/KishorKumar0/32-Bit-MAC-Unit-Design/assets/144250655/2b76b466-6b9a-4a07-9b18-38dfd4564eeb) -->
