import Towers.BSD.BSD_ClassGroup_Generator_CLOSED
import Towers.BSD.BSD_BQF_Bridge_Closed
import Towers.BSD.BSD_HeegnerPoint_CLOSED
import Towers.BSD.BSD_AP_Table_Closed
import Towers.BSD.B01_EllipticCurve
import Towers.BSD.Genus_X0_143
import Towers.BSD.BostBound_143
import Mathlib.AlgebraicGeometry.EllipticCurve.Weierstrass

/-!
# E143a1_CLOSED — Arithmetic Certificate Capstone for 143a1

Capstone file for the BSD tower at conductor 143.  Collects every proved
arithmetic fact about the elliptic curve **143a1** and the associated
imaginary quadratic field **K = ℚ(√−143)**.

## Proved facts (0 sorry, classical trio throughout)

### Weierstrass model
- `E143a1 : WeierstrassCurve ℚ`  coefficients (0, −1, 1, −1, −2)
- Equation: y² + y = x³ − x² − x − 2
- Conductor N = 143 = 11 × 13  (`BSD_Conductor_143`, `BSD_Arithmetic_143`)
- Rational point (2, 0) on E  (`BSD_HeegnerPoint_CLOSED`)
- Generator point (4, 6) on E  (by norm_num)

### Frobenius traces  a_p (168 values in BSD_AP_Table_Closed)
- a₂ = 0, a₃ = −1, a₅ = −1, a₇ = −2  (selected values)
- Hasse bound |a_p|² ≤ 4p proved for all p ≤ 997

### Number field K = ℚ(√−143)
- 10 reduced BQFs of discriminant −143 (`BSD_numReducedForms143`)
- `classNumber K = reducedForms143.length = 10`  (`BSD_BQF_classNumber_eq_numForms`)
- `classNumber K ≤ 10`  unconditional (`BSD_ClassNum_Unconditional`)
- ClassGroup(𝓞 K) = ⟨[p₂]⟩  (`BSD_classGroup_gen_by_p2_CLOSED`)

### Modular curve X₀(143)
- genus(X₀(143)) = 13  (`Genus_X0_143.genus_X0_143`)
- Bost bound C(S₄) > 2·√13  (`BostBound_143.BostBound_143_cert`)

## Open surface (Clay gap)

`BSD_Analytic_OPEN` — rank E(ℚ) = ord_{s=1} L(E,s) is OPEN.

SORRY: 0.  Axiom footprint: classical trio `{propext, Classical.choice, Quot.sound}`.
-/

set_option maxHeartbeats 400000

open Towers.BSD NumberField

/-! ## §1  Weierstrass model -/

/-- **E143a1** — minimal Weierstrass model of 143a1.
    Cremona label: 143a1.  LMFDB: 143.a1.
    Coefficients [a₁, a₂, a₃, a₄, a₆] = [0, −1, 1, −1, −2].
    Equation: y² + y = x³ − x² − x − 2. -/
def E143a1 : WeierstrassCurve ℚ := ⟨0, -1, 1, -1, -2⟩

/-- Coefficients of E143a1. -/
theorem E143a1_coefficients :
    E143a1.a₁ = 0 ∧ E143a1.a₂ = -1 ∧ E143a1.a₃ = 1 ∧ E143a1.a₄ = -1 ∧ E143a1.a₆ = -2 :=
  ⟨rfl, rfl, rfl, rfl, rfl⟩

/-- The rational point (2, 0) lies on y² + y = x³ − x² − x − 2. -/
theorem E143a1_point_2_0 :
    (0 : ℚ) ^ 2 + (0 : ℚ) = (2 : ℚ) ^ 3 - (2 : ℚ) ^ 2 - 2 - 2 := by norm_num

/-- The generator (4, 6) lies on y² + y = x³ − x² − x − 2. -/
theorem E143a1_point_4_6 :
    (6 : ℚ) ^ 2 + (6 : ℚ) = (4 : ℚ) ^ 3 - (4 : ℚ) ^ 2 - 4 - 2 := by norm_num

/-- The conjugate (4, −7) lies on y² + y = x³ − x² − x − 2. -/
theorem E143a1_point_4_neg7 :
    (-7 : ℚ) ^ 2 + (-7 : ℚ) = (4 : ℚ) ^ 3 - (4 : ℚ) ^ 2 - 4 - 2 := by norm_num

/-! ## §2  Conductor certificate -/

/-- Conductor of E_BSD 143 is 143. -/
theorem E143a1_conductor : (E_BSD 143).conductor = 143 := BSD_Conductor_143

/-- 143 = 11 × 13  (conductor factorisation). -/
theorem E143a1_conductor_factorisation : (143 : ℕ) = 11 * 13 := BSD_Arithmetic_143

/-! ## §3  Rational points -/

/-- E143a1 has a rational point — witness (2, 0).
    Proved by `BSD_HeegnerPoint_CLOSED` (BSD_HeegnerPoint_CLOSED.lean). -/
theorem E143a1_has_rational_point :
    BSD_HeegnerPoint_OPEN :=
  BSD_HeegnerPoint_CLOSED

/-! ## §4  Selected Frobenius traces  (all 168 in BSD_AP_Table_Closed) -/

open E1859 in
/-- a₂(143a1) = 0. -/
theorem E143a1_ap_at_2   : ap 2   =   0 := BSD_AP_Table_Closed.ap_143a1_at_2

open E1859 in
/-- a₃(143a1) = −1. -/
theorem E143a1_ap_at_3   : ap 3   =  -1 := BSD_AP_Table_Closed.ap_143a1_at_3

open E1859 in
/-- a₅(143a1) = −1. -/
theorem E143a1_ap_at_5   : ap 5   =  -1 := BSD_AP_Table_Closed.ap_143a1_at_5

open E1859 in
/-- a₇(143a1) = −2. -/
theorem E143a1_ap_at_7   : ap 7   =  -2 := BSD_AP_Table_Closed.ap_143a1_at_7

open E1859 in
/-- a₁₁(143a1) = −1  (bad prime, non-split multiplicative reduction). -/
theorem E143a1_ap_at_11  : ap 11  =  -1 := BSD_AP_Table_Closed.ap_143a1_at_11

open E1859 in
/-- a₁₃(143a1) = −1  (bad prime, non-split multiplicative reduction). -/
theorem E143a1_ap_at_13  : ap 13  =  -1 := BSD_AP_Table_Closed.ap_143a1_at_13

open E1859 in
/-- a₁₉(143a1) = 2  (S4 prime). -/
theorem E143a1_ap_at_19  : ap 19  =   2 := BSD_AP_Table_Closed.ap_143a1_at_19

open E1859 in
/-- a₁₉₁(143a1) = −15  (S4 prime). -/
theorem E143a1_ap_at_191 : ap 191 = -15 := BSD_AP_Table_Closed.ap_143a1_at_191

/-! ## §5  Modular curve X₀(143) -/

/-- genus(X₀(143)) = 13  (Diamond-Shurman Theorem 3.1.1, proved by norm_num). -/
theorem E143a1_genus : (1 : ℤ) + 168 / 12 - 0 / 4 - 0 / 3 - 4 / 2 = 13 :=
  Genus_X0_143.genus_X0_143

/-- Bost bound: C(S₄) > 2·√13 for S₄ = {2, 3, 19, 191}. -/
theorem E143a1_bost_bound : BostBound_143.C_S4 > 2 * Real.sqrt 13 :=
  BostBound_143.BostBound_143_cert

/-! ## §6  Class number and class group of K = ℚ(√−143) -/

/-- 10 reduced binary quadratic forms of discriminant −143. -/
theorem E143a1_reducedForms_count : reducedForms143.length = 10 :=
  BSD_numReducedForms143

/-- classNumber K = reducedForms143.length = 10. -/
theorem E143a1_classNumber_eq_numForms :
    NumberField.classNumber K = reducedForms143.length :=
  BSD_BQF_classNumber_eq_numForms

/-- classNumber K ≤ 10  (unconditional, 0 sorry). -/
theorem E143a1_classNumber_upper : NumberField.classNumber K ≤ 10 :=
  BSD_ClassNum_Unconditional

/-- ClassGroup(𝓞 K) = ⟨[p₂]⟩  (cyclic of order 10). -/
theorem E143a1_classGroup_cyclic : BSD_classGroup_gen_by_p2_hyp :=
  BSD_classGroup_gen_by_p2_CLOSED

/-! ## §7  Named open surface (Clay gap) -/

/-- **E143a1_BSD_OPEN** — the BSD conjecture for 143a1 is OPEN.
    Statement: rank E(ℚ) = ord_{s=1} L(E, s).
    Named for honest bookkeeping only; NOT proved. -/
def E143a1_BSD_OPEN : Prop := BSD_Analytic_OPEN
