import Towers.BSD.BSD_Clay_Certificate
import Towers.BSD.BSD_ClassNum_Unconditional_CLOSED
import Towers.BSD.Genus_X0_143
import Towers.BSD.BostBound_143
import Towers.BSD.BSD_BQF_Bridge_Closed
import Towers.BSD.BSD_ClassGroup_Generator_CLOSED
import Towers.BSD.E143a1_CLOSED

/-!
# BSD_Clay_6gate_CLOSED — Genesis-722 Clay Gate Reduction

## Purpose

Extends `BSD_Clay_Certificate` with the genesis-722 batch discharge.

**Two gates discharged unconditionally this batch:**

  1. `BSD_classNumber_upper_OPEN` (classNumber K ≤ 10) — proved by
     `BSD_ClassNum_Unconditional` (BSD_ClassNum_Unconditional_CLOSED.lean).
     Clay combinator drops from **7 → 6 explicit surface parameters**.

  2. `BSD_HeegnerPoint_OPEN` (∃ P ∈ 143a1(ℚ)) — proved by
     `BSD_HeegnerPoint_CLOSED` (witness (2, 0); BSD_HeegnerPoint_CLOSED.lean).

## Genesis-722 arithmetic cross-references

All five Phase-12 facts are referenced by name:

  | Fact                                | Theorem                         |
  |-------------------------------------|---------------------------------|
  | genus(X₀(143)) formula = 13        | E143a1_genus                    |
  | Bost bound C_S4 > 2·√13            | E143a1_bost_bound               |
  | classNumber K = #reducedForms (=10) | E143a1_classNumber_eq_numForms  |
  | classNumber K ≤ 10                  | E143a1_classNumber_upper        |
  | ClassGroup K = ⟨[𝔭₂]⟩             | E143a1_classGroup_cyclic        |

## Updated open surface count

  DISCHARGED (this batch, unconditional):
    BSD_classNumber_upper_OPEN — classNumber K ≤ 10
    BSD_HeegnerPoint_OPEN      — ∃ P ∈ 143a1(ℚ) (proved = (2, 0))

  REMAINING genuine Clay gaps: **11 named open surfaces**
    (down from 13 in BSD_clay_cert_open_count)

    BSD_HasseFull_143_OPEN            — Frobenius for primes > 997
    BSD_LFunction_Identification_OPEN — BSDLFunction = Dirichlet series
    BSD_AnalyticContinuation_143_OPEN — analytic continuation
    BSD_GammaFuncEq_143_OPEN          — functional equation
    BSD_LFunctionZero_OPEN            — L(E_{143},1) = 0
    BSD_AnalyticRankOne_OPEN          — ord_{s=1} L = 1
    BSD_Regulator_OPEN 143            — Néron–Tate regulator > 0
    BSD_Sha_OPEN 143                  — |Ш(E_{143}/ℚ)| finite
    BSD_TamagawaConj_OPEN 143         — Tamagawa product formula
    BSD_Tamagawa_11_is_1_OPEN         — c₁₁ = 1 (Néron model gap)
    BSD_Tamagawa_13_is_2_OPEN         — c₁₃ = 2 (Néron model gap)
    BSD_143_OPEN                      — BSD conjecture (rank = analytic rank)

SORRY: 0.  Axiom footprint: classical trio {propext, Classical.choice, Quot.sound}.
BSD: OPEN.  NOT a brick.  NOT a Clay submission.
-/

set_option maxHeartbeats 400000

namespace Towers.BSD

open NumberField NumberField.InfinitePlace Real

-- ============================================================
-- §1. Discharge BSD_classNumber_upper_OPEN unconditionally
-- ============================================================

/-- **BSD_classNumber_upper_DISCHARGED** (0 sorry, classical trio):
    `BSD_classNumber_upper_OPEN` (classNumber K ≤ 10) proved unconditionally.

    Source: `BSD_ClassNum_Unconditional` (BSD_ClassNum_Unconditional_CLOSED.lean).
    Effect: removes `h_upper` from `BSD_ClayCompliance_7gate` → 6-gate. -/
theorem BSD_classNumber_upper_DISCHARGED : BSD_classNumber_upper_OPEN :=
  BSD_ClassNum_Unconditional

-- ============================================================
-- §2. Discharge BSD_HeegnerPoint_OPEN (cross-reference)
-- ============================================================

/-- **BSD_HeegnerPoint_DISCHARGED** (0 sorry, classical trio):
    `BSD_HeegnerPoint_OPEN` (∃ rational point on 143a1) proved.

    Source: `BSD_HeegnerPoint_CLOSED` (witness (2, 0), BSD_HeegnerPoint_CLOSED.lean).
    No longer counted among genuine Clay gaps. -/
theorem BSD_HeegnerPoint_DISCHARGED : BSD_HeegnerPoint_OPEN :=
  BSD_HeegnerPoint_CLOSED

-- ============================================================
-- §3. Genesis-722 arithmetic cross-references (Phase 12)
-- ============================================================

/-- Genus formula: 1 + μ(143)/12 − ν₂/4 − ν₃/3 − ν∞/2 = 13.
    Source: E143a1_genus (E143a1_CLOSED.lean → Genus_X0_143.lean). -/
theorem BSD_722_genus_13 : (1 : ℤ) + 168 / 12 - 0 / 4 - 0 / 3 - 4 / 2 = 13 :=
  E143a1_genus

/-- Bost bound: C_S4 > 2·√13 (genus = 13, fourteen-cusp surface).
    Source: E143a1_bost_bound (E143a1_CLOSED.lean → BostBound_143.lean). -/
theorem BSD_722_bost_bound : BostBound_143.C_S4 > 2 * Real.sqrt 13 :=
  E143a1_bost_bound

/-- Class number = number of reduced forms (both = 10).
    Source: E143a1_classNumber_eq_numForms (E143a1_CLOSED.lean). -/
theorem BSD_722_classNumber_eq_numForms :
    NumberField.classNumber K = reducedForms143.length :=
  E143a1_classNumber_eq_numForms

/-- classNumber K ≤ 10 (upper gate, unconditional).
    Source: E143a1_classNumber_upper (E143a1_CLOSED.lean). -/
theorem BSD_722_classNumber_upper : NumberField.classNumber K ≤ 10 :=
  E143a1_classNumber_upper

/-- ClassGroup(𝓞 K) is cyclic, generated by [𝔭₂].
    Source: E143a1_classGroup_cyclic (E143a1_CLOSED.lean). -/
theorem BSD_722_classGroup_cyclic : BSD_classGroup_gen_by_p2_hyp :=
  E143a1_classGroup_cyclic

-- ============================================================
-- §4. 6-gate Clay combinator (h_upper discharged)
-- ============================================================

/-- **BSD_ClayCompliance_6gate** (0 sorry, classical trio):
    Clay BSD gate combinator with class-number upper gate unconditionally discharged.

    Drops `h_upper : BSD_classNumber_upper_OPEN` from `BSD_ClayCompliance_7gate`
    by supplying `BSD_ClassNum_Unconditional` unconditionally.

    Remaining 6 analytic / Clay gaps as explicit parameters:
      1. BSD_HasseFull_143_OPEN    — Frobenius for primes > 997 (Wiles–Taylor gap)
      2. BSD_L_Analytic_143_OPEN   — L-function identification + analytic continuation
      3. BSD_FuncEq_OPEN 143       — functional equation (Hecke theory gap)
      4. BSD_Regulator_OPEN 143    — Néron–Tate regulator > 0 (height pairing gap)
      5. BSD_Sha_OPEN 143          — |Ш(E_{143}/ℚ)| finite (Kolyvagin gap)
      6. BSD_TamagawaConj_OPEN 143 — Tamagawa product formula (Néron model gap)
    Plus the Clay core (always the terminal parameter):
      7. BSD_143_OPEN              — BSD conjecture (rank = analytic rank)

    NOT a brick.  BSD: OPEN.  NOT a Clay submission. -/
theorem BSD_ClayCompliance_6gate
    (h_hasse  : BSD_HasseFull_143_OPEN)
    (h_hecke  : BSD_L_Analytic_143_OPEN)
    (h_feq    : BSD_FuncEq_OPEN 143)
    (h_reg    : BSD_Regulator_OPEN 143)
    (h_sha    : BSD_Sha_OPEN 143)
    (h_tam    : BSD_TamagawaConj_OPEN 143)
    (h_bsd    : BSD_143_OPEN) :
    (E_BSD 143).conductor = 143 ∧
    (143 : ℕ) = 11 * 13 ∧
    NrRealPlaces K = 0 ∧
    (2 / π * sqrt 143 < 8) ∧
    NumberField.classNumber K = 10 ∧
    BSD_143_OPEN :=
  BSD_ClayCompliance_7gate h_hasse h_hecke h_feq h_reg h_sha h_tam
    BSD_classNumber_upper_DISCHARGED h_bsd

-- ============================================================
-- §5. Updated open surface count (genesis-722)
-- ============================================================

/-- Updated Clay open surface count after genesis-722.

    Previous count (BSD_clay_cert_open_count in BSD_Clay_Certificate): 13.

    Discharged this batch (both unconditional):
      BSD_classNumber_upper_OPEN — classNumber K ≤ 10
      BSD_HeegnerPoint_OPEN      — ∃ rational point (proved = (2, 0))

    Remaining: **11 genuine Clay gaps**
    (the 12th entry BSD_143_OPEN is the Clay conjecture itself). -/
def BSD_clay_open_count_722 : ℕ := 11

end Towers.BSD
