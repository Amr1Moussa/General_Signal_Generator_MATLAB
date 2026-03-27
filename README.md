
# 📡 General Signal Generator (MATLAB GUI)

A MATLAB-based GUI application developed using GUIDE that allows users to generate and manipulate different types of signals in the time domain.

---

## 🎯 Project Overview

This project implements a **General Signal Generator** capable of:

- Generating signals over a defined time range
- Supporting multiple signal types across different regions
- Applying signal operations such as scaling, shifting, and time transformations
- Visualizing signals interactively using a graphical interface

---

## ⚙️ Features

### 🧩 Signal Generation
- User-defined:
  - Sampling frequency
  - Time range
  - Breakpoints (to divide signal into regions)

- Supported signal types:
  - **DC Signal**
  - **Ramp Signal**
  - **Polynomial Signal**
  - **Exponential Signal**
  - **Sinusoidal Signal**

- Each region is defined **iteratively via dialog boxes**

---

### 🔄 Signal Operations

After generating the signal, users can apply:

- 🔹 Amplitude Scaling  
- 🔹 Time Reversal  
- 🔹 Time Shift  
- 🔹 Time Expansion  
- 🔹 Time Compression  

---

### 📊 Visualization

- Real-time plotting in the time domain
- Styled dark-themed GUI
- Grid support
- Clear and update functionality

---

## 🖥️ GUI Interface

The GUI includes:

- Input fields for:
  - Sampling frequency
  - Start and end time
  - Breakpoints
- Buttons for:
  - Display signal
  - Perform operations
  - Clear / Reset
  - Close application

Signal parameters for each region are entered through **interactive dialogs**.

---

## 🛠️ Technologies Used

- MATLAB
- GUIDE (Graphical User Interface Development Environment)

---

## 🚀 How to Run

1. Open MATLAB
2. Navigate to the project folder
3. Run the main file:

```matlab
signal_generator
````

4. Enter:

   * Sampling frequency
   * Time range
   * Breakpoints

5. Define each region step-by-step

6. Visualize and apply operations

---

## 📌 Example

**Inputs:**

* Sampling Frequency: `100`
* Time Range: `0 to 5`
* Breakpoints: `3 4`

**Regions:**

* Region 1: `[0 → 3]` → DC
* Region 2: `[3 → 4]` → Ramp
* Region 3: `[4 → 5]` → Sinusoidal

---

## 👨‍💻 Team Members

| Name                       | ID       |
| -------------------------- | -------- |
| Amr Mahmoud Moussa         | 23010637 |
| Yasen Mohamed Ahmed Salhin | 23010962 |

---

## 📄 Notes

* The project uses **iterative region definition**, making it flexible for complex signals.
* Input validation is implemented to prevent invalid configurations.
* The GUI is styled for better usability and visualization.

---

## 📷 Screenshots

> *(Add screenshots of your GUI and output here)*

---

## 📬 Submission

This project is part of the **Signals & Systems Mini Project**.

---

## ⭐ Future Improvements

* Export signal to file
* Frequency domain visualization (FFT)
* Real-time signal editing
* Migration to App Designer

---

```

---

## 🔥 Tips before uploading

- Add:
  - screenshots (VERY important for grading)
- Keep file name:
```

signal_generator.fig
signal_generator.m
README.md

```

---

If you want, I can also:
- write the **full report PDF**
- or generate **GitHub screenshots section automatically styled**

Just tell me 👍
```
