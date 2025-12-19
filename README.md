# MCU SoC – Physical Design Case Study (OpenLane / Sky130)


This project is a hands-on **Physical Design case study** where I took a small MCU-class SoC from RTL all the way through **full place & route, CTS, PDN, routing, and signoff** using **OpenLane v1.1.x** and the **Sky130** PDK.

The goal of this project was not just to get a clean run, but to **learn and demonstrate real PD decision-making**: timing constraints, floorplan trade-offs, PDN failures, CTS behavior, and layout inspection.

---

## 1. Design Overview

* **Design name**: `soc_top`
* **Type**: MCU-class SoC (simple CPU + GPIO)
* **Process**: Sky130 (130 nm)
* **Standard cell library**: `sky130_fd_sc_hd`
* **Target frequency**: 50 MHz (20 ns clock)

This is a small design, but the PD flow is realistic and complete.

---

## 2. Toolchain

* **RTL → GDS flow**: OpenLane v1.1.x
* **Synthesis / STA**: OpenROAD
* **Placement / CTS / Routing**: OpenROAD + TritonRoute
* **Layout viewer**: KLayout

---

## 3. Floorplan

I manually explored utilization and die sizing instead of relying on defaults.

**Final floorplan used for signoff:**

* **Die area**: `(0.0, 0.0) – (80.0, 80.0) µm`
* **Core area**: `(5.52, 10.88) – (74.06, 68.0) µm`
* **Core utilization**: ~65%
* **Aspect ratio**: 1.0

This die size was chosen after hitting PDN pitch violations with a smaller core.

---

## 4. Timing Constraints (SDC Ownership)

I wrote and owned a custom SDC instead of relying on defaults.

Key points:

* Explicit clock definition (20 ns)
* Clock uncertainty and transition modeled
* Input/output delays applied
* Reset excluded from timing

This helped eliminate STA warnings and made timing intent clear.

---

## 5. PDN Debug (Real Failure Encountered)

During early runs, **PDN generation failed** with:

```
PDN-0175: Pitch too small, must be at least 6.6 µm
```

**Root cause**:

* Core area was too small for minimum power strap pitch rules

**Fix applied**:

* Increased die size
* Reduced effective congestion
* Allowed PDN straps to meet spacing rules

This was not a tool bug — it was a real physical rule being enforced.

After the fix, PDN generation passed cleanly.

---

## 6. Clock Tree Synthesis (CTS)

CTS completed successfully with clean timing.

Post-CTS timing summary:

* **WNS**: 0.00 ns
* **TNS**: 0.00 ns
* **Worst setup slack**: +4.98 ns
* **Worst hold slack**: +0.33 ns

This confirms proper clock insertion and no hold-time issues.

---

## 7. Routing & Signoff

* Routed successfully with **0 DRC violations**
* No antenna violations
* No LVS or layout errors
* Routing used layers **M1–M6**

Basic routing stats:

* **Total wire length**: ~528k µm
* **Via count**: 568

---

## 8. Power Summary (Typical Corner)

From signoff metrics:

* **Internal power**: ~73 µW
* **Switching power**: ~12 µW
* **Leakage**: negligible

Power numbers are reasonable for a 130 nm design at 50 MHz.

---

## 9. Layout Evidence

Screenshots were captured in **KLayout** showing:

* Full routed chip
* PDN straps
* Clock tree routing
* Detailed routing zoom

Images are stored in:

```
docs/images/
```

---

## 10. What I Learned

This project helped me understand:

* Why utilization must balance timing and routability
* How PDN rules depend on core size
* How CTS reacts to congestion
* How to read OpenLane metrics instead of guessing
* How to debug real PD failures instead of restarting runs

---

## 11. Next Improvements

Possible next steps:

* Multi-corner STA analysis
* Higher utilization stress runs
* Larger SoC integration
* Power-aware floorplanning

---

This project represents my current hands-on understanding of **Physical Design fundamentals** and how to reason about PD trade-offs using real tools and real constraints.
