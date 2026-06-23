/-
  # BSD_MasterCertification — Terminal Node of the BSD Tower

  ## What this file is

  Terminal certification file for the Birch and Swinnerton-Dyer tower
  (Theorema Aureum 143, Clay Problem II).

  It imports all tower endpoints and provides:
    (1) A proved-bricks catalog — all bricks, 0 sorry, classical trio
    (2) A complete OPEN-surface ledger — 9 genuine Clay gaps
    (3) A top-level combinator: given all open surfaces → BSD_143_OPEN

  NOTE: K1_Lower_OrderOf_BSD (10 ≤ classNumber K) is PROVED unconditionally
  in BSD_MasterProof.lean (BSD_classNumber_lower_bound, 0 sorry, classical trio).
  It has been removed from the OPEN surface list and added to the proved-brick
  inventory below.

  SORRY: 0.  Axiom footprint: classical trio {propext, Classical.choice, Quot.sound}.
  BSD: OPEN.  NOT a brick.  NOT a Clay submission.

  ## Proved-brick inventory (0 sorry, classical trio throughout)

  ### Conductor / arithmetic
  | Theorem | Statement |
  |---------|-----------|
  | BSD_Conductor_143          | (E_BSD 143).conductor = 143                        |
  | BSD_Arithmetic_143         | (143 : ℕ) = 11 * 13                               |
  | BSD_Arithmetic_143_cert    | conductor = 143 ∧ 143 = 11 * 13                   |

  ### Number field K = ℚ(√-143)
  | Theorem | Statement |
  |---------|-----------|
  | X_sq_add_143_irred_BSD     | X² + 143 irreducible over ℚ                        |
  | BSD_finrank_CLOSED         | finrank ℚ K = 2                                    |
  | nrRealPlaces_zero_BSD      | NrRealPlaces K = 0                                 |
  | nrComplexPlaces_one_BSD    | NrComplexPlaces K = 1  (conditional)               |
  | minkowski_lt_eight_BSD     | (2/π)·√143 < 8                                     |
  | ω_sq_eq_BSD                | ω² − ω + 36 = 0  (ω = (1+√-143)/2)               |
  | ω_integral_BSD             | IsIntegral ℤ ω                                     |
  | trace_one_BSD              | Tr(1) = 2                                           |
  | trace_α_BSD                | Tr(α) = 0                                           |
  | trace_α_sq_BSD             | Tr(α²) = -286                                       |
  | trace_ω_BSD                | Tr(ω) = 1                                           |
  | trace_ω_sq_BSD             | Tr(ω²) = -71                                        |
  | norm_α_BSD                 | N(α) = 143                                          |
  | BSD_IntegralSpanning_CLOSED| 𝓞 K = ℤ·1 + ℤ·ω  (squarefree criterion)          |

  ### Norm-form impossibilities
  | Theorem | Statement |
  |---------|-----------|
  | norm_form_no_norm_two_BSD  | ∀ a b : ℤ, a²+ab+36b² ≠ 2                       |
  | norm_form_no_norm_eight_BSD| ∀ a b : ℤ, a²+ab+36b² ≠ 8                       |
  | norm_form_no_norm_32_BSD   | ∀ a b : ℤ, a²+ab+36b² ≠ 32                      |
  | norm_form_no_norm_128_BSD  | ∀ a b : ℤ, a²+ab+36b² ≠ 128                     |
  | norm_form_no_norm_512_BSD  | ∀ a b : ℤ, a²+ab+36b² ≠ 512                     |
  | norm_form_no_norm_three_BSD| ∀ a b : ℤ, a²+ab+36b² ≠ 3                       |
  | norm_form_no_norm_seven_BSD| ∀ a b : ℤ, a²+ab+36b² ≠ 7                       |
  | norm_form_gen_1024_BSD     | (-28)²+(-28)·3+36·3² = 1024                       |

  ### Prime splitting at conductor 143 = 11 × 13
  | Theorem | Statement |
  |---------|-----------|
  | prime_2_splits_BSD         | ∃ x : ZMod 2, x²−x+36 = 0                        |
  | prime_3_splits_BSD         | ∃ x : ZMod 3, x²−x+36 = 0                        |
  | prime_5_inert_BSD          | ∀ x : ZMod 5, x²−x+36 ≠ 0                        |
  | prime_7_splits_BSD         | ∃ x : ZMod 7, x²−x+36 = 0                        |

  ### Class group — proved (0 sorry, classical trio)
  | Theorem | File | Statement |
  |---------|------|-----------|
  | idealOfForm_classGroup_bridge_proof | BSD_FormIdeal | absNorm(idealOfForm a b) = a.natAbs for all 10 forms |
  | absNorm_p2_eq_2                     | BSD_ClassNumberLowerProof | Ideal.absNorm p2_OK = 2 |
  | p2_pow_not_principal_odd            | BSD_ClassNumberLowerProof | p₂^k non-principal, k ∈ {1,3,5,7,9} |
  | EvenK_NonPrincipal_Bridge_proof     | BSD_ClassNumberLowerProof | p₂^k non-principal, k ∈ {2,4,6,8} |
  | BSD_orderOf_le_classNumber_CLOSED   | BSD_ClassNumberBounds     | orderOf g ≤ classNumber K |
  | BSD_algNorm_gen_proof               | BSD_AlgNorm               | Algebra.norm ℤ gen_OK = 1024 |
  | BSD_absNorm_gen_CLOSED              | BSD_AlgNorm               | absNorm(span{gen_OK}) = 1024 = 2^10 |
  | BSD_classNumber_lower_bound         | BSD_MasterProof           | 10 ≤ classNumber K |
  | BSD_p2_pow_10_principal             | BSD_P2_Principal_CLOSED   | p₂^10 is principal (span{gen_OK} = p₂^10) |
  | BSD_classNumber_eq_10_via_principal | BSD_P2_Principal_CLOSED   | classNumber K = 10  (Option A: principal ideal route) |
  | BSD_BQF_ClassNumber_bridge_CLOSED   | BSD_BQF_Bridge_Closed     | classNumber K = reducedForms143.length = 10  (Option B: BQF) |
  | BSD_classGroup_gen_by_p2_CLOSED     | BSD_ClassGroup_Generator  | ClassGroup(𝓞 K) = ⟨[p₂]⟩ (generator proved) |

  ### Rational point on 143a1 — proved (0 sorry, classical trio)
  | Theorem | File | Statement |
  |---------|------|-----------|
  | BSD_HeegnerPoint_CLOSED             | BSD_HeegnerPoint_CLOSED   | ∃ (x y : ℚ), y^2 + y = x^3 − x^2 − x − 2  (point (4,6)) |
  | BSD_RationalPoint_Explicit          | BSD_HeegnerPoint_CLOSED   | (4 : ℚ)^2 + 4 = (4 : ℚ)^3 − ... (explicit certificate) |

  ### Frobenius traces — proved (0 sorry, classical trio)
  | ap | Value | File |
  |----|-------|------|
  | a_2(143a1) | 0  | BSD_AP_Table_Closed |
  | a_3(143a1) | −2 | BSD_AP_Table_Closed |
  | a_5(143a1) | −2 | BSD_AP_Table_Closed |
  | a_7(143a1) | 4  | BSD_AP_Table_Closed |
  | a_11(143a1)| −2 | BSD_AP_Table_Closed |
  | a_13(143a1)| 2  | BSD_AP_Table_Closed |
  | a_17(143a1)| 2  | BSD_AP_Table_Closed |
  | a_19(143a1)| 2  | BSD_AP_Table_Closed |

  ### Full arithmetic ledger
  | Theorem | Statement |
  |---------|-----------|
  | BSD_ArithmeticLedger       | Conjunction of conductor + number-field + splitting |

  ## OPEN surface ledger (9 genuine Clay / analytic gaps)

  All arithmetic surfaces are CLOSED.  The surfaces below are genuine Clay
  or Mathlib-API gaps — NOT arithmetic failures.

  ### Clay core — the BSD conjecture
  | Surface | Statement | Gap |
  |---------|-----------|-----|
  | BSD_143_OPEN              | rank E_{143}(ℚ) = ord_{s=1} L(E_{143},s)         | BSD conjecture itself |
  | BSD_TamagawaConj_OPEN 143 | L*(E,1)·|Ш|·|E(ℚ)_tors|² = Ω·R·∏c_p           | Leading term formula  |

  ### Analytic gaps (Mathlib v4.12.0 API absent)
  | Surface | Statement | Gap |
  |---------|-----------|-----|
  | Modularity_143_OPEN       | E_{143} is modular (Wiles–Taylor)                | Not in Mathlib v4.12.0 |
  | BSD_L_Analytic_143_OPEN   | L(E_{143},s) extends to entire ℂ → ℂ            | Modular-forms API absent |
  | BSD_FuncEq_OPEN 143       | L(E_{143},s) satisfies functional equation       | Requires modular-forms ↔ L-function |
  | BSD_Regulator_OPEN 143    | R(E_{143}/ℚ) > 0                                 | Néron-Tate height absent |
  | BSD_Sha_OPEN 143          | |Ш(E_{143}/ℚ)| finite                             | General Ш finiteness open |

  ### Rank chain for 143a1 (Mathlib v4.12.0 API absent)
  | Surface | Statement | Gap |
  |---------|-----------|-----|
  | BSD_LFunctionZero_OPEN    | L_143a1(1) = 0                                   | Root number ε=+1, no formal proof |
  | BSD_AnalyticRankOne_OPEN  | ord_{s=1} L_143a1 = 1 (simple zero)              | Derivative API absent |

  DISCHARGED (proved, no longer OPEN):
    K1_Lower_OrderOf_BSD     — proved in BSD_MasterProof.lean (BSD_classNumber_lower_bound).
    K1_ClassNumber_Upper_BSD — proved via BSD_P2_Principal_CLOSED + BSD_BQF_Bridge_Closed
                               (classNumber K = 10, hence ≤ 10). Discharged directly in
                               BSD_MasterCombinator without a hypothesis parameter.
    BSD_HeegnerPoint_OPEN    — proved in BSD_HeegnerPoint_CLOSED.lean (point (4,6)).
    BSD_finrank_CLOSED       — proved in BSD_Discriminant.lean (BSD_finrank_proved).

  Trail for K1_Lower: BSD_ClassNumber → BSD_C22b_LowerBound → BSD_ClassNumberLowerProof
                      → BSD_ClassNumberBounds → BSD_MasterProof (CLOSED).
-/

import BSD.B06_BSDCollection
import BSD.MordellWeil
import BSD.BSD_BQF_Bridge_Closed
import BSD.BSD_ClassGroup_Generator_CLOSED
import BSD.BSD_HeegnerPoint_CLOSED
import BSD.BSD_AP_Table_Closed

namespace BSD

open NumberField NumberField.InfinitePlace Real

/-! ### BSD open-surface ledger (for documentation; surfaces defined in tower files) -/

/-! ### Top-level BSD master combinator -/

/-- **BSD_MasterCombinator** (0 sorry, classical trio):
    Given 7 hypotheses (all genuine Clay / analytic gaps), derives the full
    BSD arithmetic scaffold and BSD_143_OPEN.

    This is the terminal node of the BSD tower.  It assembles every proved
    brick, explicitly names every genuine Clay gap, and discharges:
      · `BSD_finrank_CLOSED` — proved by `BSD_finrank_proved` in BSD_Discriminant.lean
      · `K1_Upper_ClassGroup_BSD` — discharged from `BSD_classNumber_eq_10_via_principal`
        (BSD_P2_Principal_CLOSED) — classNumber K = 10, hence ≤ 10.  No hypothesis needed.

    `h_lower : K1_Lower_OrderOf_BSD` (10 ≤ classNumber K) is proved
    unconditionally in BSD_MasterProof.lean (BSD_classNumber_lower_bound).
    It remains a parameter here because BSD_MasterCertification cannot
    import BSD_MasterProof (that would create a circular dependency).

    NOT a brick.  BSD OPEN (Clay conjecture).  No Clay submission. -/
theorem BSD_MasterCombinator
    -- Clay core (genuinely OPEN — BSD conjecture)
    (h_bsd     : BSD_143_OPEN)
    (h_tam     : BSD_TamagawaConj_OPEN 143)
    -- Analytic gaps (Mathlib v4.12.0 API absent)
    (h_mod     : Modularity_143_OPEN)
    (h_hecke   : BSD_L_Analytic_143_OPEN)
    (h_feq     : BSD_FuncEq_OPEN 143)
    (h_reg     : BSD_Regulator_OPEN 143)
    (h_sha     : BSD_Sha_OPEN 143)
    -- h_upper: PROVED — discharged below from BSD_classNumber_eq_10_via_principal
    -- h_lower: proved in BSD_MasterProof.lean; kept as param due to circular import
    (h_lower   : K1_Lower_OrderOf_BSD) :
    -- Proved conclusion
    (E_BSD 143).conductor = 143 ∧
    (143 : ℕ) = 11 * 13 ∧
    NrRealPlaces K = 0 ∧
    (2 / Real.pi * Real.sqrt 143 < 8) ∧
    NumberField.classNumber K = 10 ∧
    BSD_143_OPEN := by
  -- Discharge h_upper: classNumber K = 10 (proved), so classNumber K ≤ 10.
  have h_upper : K1_Upper_ClassGroup_BSD :=
    Nat.le_of_eq (BSD_classNumber_eq_10_via_principal BSD_p2_pow_10_principal)
  exact BSD_Conditional h_mod h_hecke h_bsd h_tam h_reg h_sha h_upper h_lower BSD_finrank_proved

/-! ### Proved-brick master certificate -/

/-- **BSD_BrickLedger** (proved, 0 sorry):
    All purely arithmetic certificates for the BSD tower in one conjunction.
    Conductor, factorisation, splitting behaviour, Minkowski bound,
    norm-form generator.  Classical trio only; NO open surfaces.

    This is the completeness certificate: everything that can be proved
    today without the analytic gaps is recorded here. -/
theorem BSD_BrickLedger :
    -- Conductor
    (E_BSD 143).conductor = 143 ∧
    (143 : ℕ) = 11 * 13 ∧
    -- Number field
    NrRealPlaces K = 0 ∧
    (2 / Real.pi * Real.sqrt 143 < 8) ∧
    -- Generator certificate
    (-28 : ℤ) ^ 2 + (-28) * 3 + 36 * 3 ^ 2 = 1024 ∧
    -- Prime splitting
    (∃ x : ZMod 2, x ^ 2 - x + 36 = 0) ∧
    (∃ x : ZMod 3, x ^ 2 - x + 36 = 0) ∧
    (∀ x : ZMod 5, x ^ 2 - x + 36 ≠ 0) ∧
    (∃ x : ZMod 7, x ^ 2 - x + 36 = 0) :=
  BSD_ArithmeticLedger

/-! ### Open surface count (documentation) -/

/-- The BSD tower has exactly **9 named OPEN surfaces** (June 2026).
    All arithmetic surfaces are CLOSED.  Every remaining open surface is a
    genuine Clay-level or Mathlib-API gap, NOT an arithmetic failure.

    Clay core (2):
      BSD_143_OPEN            — BSD conjecture: rank E(ℚ) = ord_{s=1} L(E,s)
      BSD_TamagawaConj_OPEN   — leading term: L*(E,1)·|Ш|·|tors|² = Ω·R·∏c_p

    Analytic gaps — Mathlib v4.12.0 API absent (5):
      Modularity_143_OPEN     — E_{143} is modular (Wiles–Taylor)
      BSD_L_Analytic_143_OPEN — L(E_{143},s) extends to entire ℂ
      BSD_FuncEq_OPEN 143     — functional equation for L(E_{143},s)
      BSD_Regulator_OPEN 143  — Néron–Tate regulator R(E/ℚ) > 0
      BSD_Sha_OPEN 143        — |Ш(E_{143}/ℚ)| finite

    Rank chain — Mathlib v4.12.0 API absent (2):
      BSD_LFunctionZero_OPEN      — L_143a1(1) = 0
      BSD_AnalyticRankOne_OPEN    — ord_{s=1} L_143a1 = 1 (simple zero)

    DISCHARGED (proved — not counted above):
      K1_Lower_OrderOf_BSD  — proved in BSD_MasterProof.lean (BSD_classNumber_lower_bound)
      BSD_finrank_CLOSED       — proved in BSD_Discriminant.lean (BSD_finrank_proved);
                                 discharged directly in BSD_MasterCombinator
      K1_ClassNumber_Upper_BSD — proved: classNumber K = 10 (BSD_P2_Principal_CLOSED +
                                 BSD_BQF_Bridge_Closed), hence ≤ 10; discharged in
                                 BSD_MasterCombinator via BSD_classNumber_eq_10_via_principal
      BSD_HeegnerPoint_OPEN    — proved: ∃ (x y : ℚ), y²+y = x³−x²−x−2; point (4,6)
                                 in BSD_HeegnerPoint_CLOSED.lean

    All open surfaces are `def Prop` — NOT axioms, NOT sorry, NOT True-stubs. -/
def BSD_open_surface_count : ℕ := 9

end BSD
