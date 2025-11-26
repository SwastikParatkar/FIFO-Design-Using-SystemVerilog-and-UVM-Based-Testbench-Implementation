# FIFO-Design-Using-SystemVerilog-and-UVM-Based-Testbench-Implementation
This project focuses on the RTL design and verification of a synchronous FIFO (First-In First-Out) memory buffer using SystemVerilog
A complete RTL design and constrained-random UVM verification environment for a synchronous FIFO (First-In First-Out) memory module. The project demonstrates industry-standard verification practices using SystemVerilog, including functional coverage, assertions, scoreboard-based checking, and reusable UVM components.

🚀 Project Overview

This project implements and verifies an **8-bit wide, 4-depth synchronous FIFO** using modern verification methodologies. The FIFO acts as a temporary data buffer that stores and retrieves data in the same order it was written (FIFO principle). To ensure design correctness, a full **UVM environment** is built, capable of constrained-random testing, functional coverage measurement, assertion checking, and automated scoreboard comparison.

---

## 🔧 **Design Description (RTL)**

The FIFO RTL includes the following features:

* Parameterized **WIDTH** and **DEPTH**
* Internal memory array
* **Write pointer** and **read pointer**
* **Full** and **Empty** status flags
* Handles **write**, **read**, **simultaneous read/write**, and **reset**

### **Key Design Operations**

| Operation | Behavior                                       |
| --------- | ---------------------------------------------- |
| Write     | Stores data at write pointer if FIFO not full  |
| Read      | Outputs data at read pointer if FIFO not empty |
| Full      | Asserted when FIFO cannot accept more data     |
| Empty     | Asserted when FIFO has no valid data           |

---

## 🧪 **UVM Verification Environment**

The testbench is built fully on UVM methodology, consisting of the following components:

### **1. Sequence Item**

Defines stimulus fields such as:

* write enable
* read enable
* write data
  Includes constraints to generate legal and illegal scenarios.

### **2. Sequence**

Generates constrained-random transactions for:

* Normal read/write
* Overflow attempt
* Underflow attempt
* Simultaneous operations

### **3. Driver**

Drives sequence items into the DUT using the interface signals.

### **4. Monitor**

Observes DUT activity and sends transactions to:

* Scoreboard
* Coverage collector

### **5. Scoreboard**

Implements a **reference model** to compare:

* Expected FIFO behavior
* Actual DUT outputs

Automatically flags mismatches.

### **6. Coverage**

Functional coverage tracks:

* Write/read events
* Full/empty conditions
* Corner cases (overflow, underflow)
* Data patterns

Ensures completeness of verification.

### **7. Assertions**

SystemVerilog assertions check:

* No read when FIFO is empty
* No write when FIFO is full
* Pointer update correctness
* Reset behavior

Assertions provide immediate bug detection.

### **8. Environment**

Creates and connects sequencer, driver, monitor, scoreboard, and coverage.

### **9. Test**

Instantiates the environment and configures:

* Constrained-random tests
* Directed tests
* Regression sweep

---

## 🔍 **Verification Features**

✔ Constrained-random stimulus
✔ Functional coverage
✔ Assertion-based verification
✔ Scoreboard reference model
✔ Reusable UVM components
✔ Clean waveform visibility
✔ Reset and corner-case testing

---

## 📂 **Project Structure**

```
├── rtl/
│   └── fifo.sv
├── tb/
│   ├── interface.sv
│   ├── seq_item.sv
│   ├── sequence.sv
│   ├── sequencer.sv
│   ├── driver.sv
│   ├── monitor.sv
│   ├── scoreboard.sv
│   ├── env.sv
│   ├── test.sv
│   └── tb.sv
├── assertions/
│   └── fifo_assertions.sv
├── coverage/
│   └── fifo_cover.sv
└── README.md
----

---

## 📝 **How to Run (EDA Playground / Simulator)**

## **Using EDA Playground**

1. Select **SystemVerilog** and **UVM 1.2**
2. Upload all files into the correct directories
3. Compile → Run
4. View logs and waveforms under "Transcript" and "Waves"

### **Using Questa/VCS**

```
vlog rtl/*.sv tb/*.sv assertions/*.sv
vsim -c tb -do "run -all"
```

---

## 📊 **Results**

The verification environment detects incorrect pointer updates, underflow/overflow bugs, and ensures FIFO operates correctly in all modes. The functional coverage reaches **100%** after running regression tests, confirming complete scenario testing.

---

## 🏁 **Conclusion**

This project demonstrates a complete RTL-to-validation flow of a synchronous FIFO using UVM methodology. It highlights the importance of reusable components, random stimulus, functional coverage, and assertion-based checking for high-quality digital design verification.

