# Exercise 11 — FIR Types I–IV (Magnitude • Phase • Zeros)

**Author:** Juan Rodriguez Esteban

## Overview

This MATLAB script plots, for four FIR filters (Types I–IV), the **magnitude response**, **unwrapped phase**, and **pole–zero diagram**. It uses the impulse responses given in the slides and arranges the results in a 4×3 figure: left column magnitude, middle column phase, right column zeros.

## FIR types at a glance

| Type | Length (M) | Symmetry      | Notes                                       |
| ---- | ---------: | ------------- | ------------------------------------------- |
| I    |       even | symmetric     | Linear phase; DC & Nyquist well-defined     |
| II   |        odd | symmetric     | Linear phase; zero at Nyquist if length odd |
| III  |       even | antisymmetric | Linear phase; zero at DC and Nyquist        |
| IV   |        odd | antisymmetric | Linear phase; zero at DC                    |

## How to run

1. Open MATLAB.
2. Save the provided script as `Exercise11.m`.
3. Run:

   ```matlab
   clear; clc; close all;
   Exercise11
   ```
4. A figure titled **Exercise 11 – Results** will be created.

## What the script does

* Computes (H(e^{j\omega})) with `freqz`.
* Plots `abs(H)` (magnitude) and `unwrap(angle(H))` (phase).
* Shows zero locations with `zplane(h,1)`.
* Includes toolbox-free fallbacks for `freqz`, `tf2zpk`, and `zplane` (so it also works in basic MATLAB installs).

## Output
> Replace the path below with the saved figure or a screenshot of your results.

![Exercise 11 - FIR Types 1-IV.bmp](https://github.com/user-attachments/files/22781005/Exercise.11.-.FIR.Types.1-IV.bmp)

