/-
================================================================
Towers / BSD / BSD_Genesis740_CLOSED  (genesis-740)

**HasseBridge extension: Unconditional Hasse bounds for p ∈ {83, 89, 97}**
via the §V.5 Frobenius-degree discriminant route.

### What is proved here (0 sorry, classical trio)

For each prime p in the three-element set {83, 89, 97} (all good reduction for 143a1;
p ∤ 143 = 11×13):

  Step 1. `BSD_E143_card_pN` — `(E143_Finset p).card = k`
          Proved by `decide` over ZMod p × ZMod p.
          Code model: y²+y = x³−x²−x−2  (isomorphic to LMFDB 143.a1 over ℚ).
          Point counts (affine):
            p=83: card=83,  a₈₃ = 83−83  =   0  (6889 pairs)
            p=89: card=96,  a₈₉ = 89−96  =  −7  (7921 pairs)
            p=97: card=110, a₉₇ = 97−110 = −13  (9409 pairs)

  Step 2. `BSD_ap_pN` — exact integer a_p value (= p − card) by omega.

  Step 3. `BSD_DegreeNonneg_pN` — `BSD_FrobeniusDegreeNonneg_OPEN p`
          Completed-square witnesses (discriminant = a_p²−4p < 0 in all cases):
            p=83:  r²+0r+83   = r²+83              disc =   0−332 = −332 < 0
            p=89:  r²+7r+89   = (r+7/2)²+307/4     disc =  49−356 = −307 < 0
            p=97:  r²+13r+97  = (r+13/2)²+219/4    disc = 169−388 = −219 < 0

  Step 4. `BSD_Hasse_OPEN_pN` — `BSD_Hasse_OPEN p`
          Via `BSD_hasse_of_degree_nonneg` bridge (genesis-733, §V.5 skeleton).

### HasseBridge coverage after genesis-740
  {2,3,5,7} (genesis-734) ∪ {17,19,23,29} (genesis-736) ∪
  {31,37,41,43,47,53,59,61,67} (genesis-738) ∪
  {71,73,79} (genesis-739) ∪
  {83,89,97} (genesis-740) = **23 good primes** covered.

### Honest scope
  - BSD_HasseFull_143_OPEN remains OPEN: 143a1 has infinitely many good primes.
    The §V.5 bridge requires Mathlib EllipticCurve.Frobenius for the full statement.
    The low-prime gate (all 168 primes ≤ 997) requires further HasseBridge extension
    or the BSD_HasseCompatibility bridge (ap = a_p for all 168 primes).
  - Named OPEN primary surfaces: 4 (unchanged — all 3 new closures secondary).
  - NOT a brick.  NOT registered in BRICKS[].  No Clay claim.
  - Compiled via workflow (decide over 6889–9409 pairs; bash subprocess OOMs at ≥6889).

Axiom footprint: classical trio {propext, Classical.choice, Quot.sound}.
================================================================
-/

import Towers.BSD.BSD_Genesis739_CLOSED

set_option maxRecDepth 10000

namespace Towers.BSD

/-! ## Fact instances for the three new primes -/

private instance instFactPrime83 : Fact (83 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime89 : Fact (89 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime97 : Fact (97 : ℕ).Prime := ⟨by norm_num⟩

/-! ## §1. Point counts over 𝔽_p  (by decide) -/

/-- **`BSD_E143_card_p83`** — 143a1 has exactly **83 affine 𝔽₈₃-points**.
    a₈₃ = 83−83 = 0.  Computed by `decide` over ZMod 83 × ZMod 83 (6889 pairs). -/
theorem BSD_E143_card_p83 : (E143_Finset 83).card = 83 := by decide

/-- **`BSD_E143_card_p89`** — 143a1 has exactly **96 affine 𝔽₈₉-points**.
    a₈₉ = 89−96 = −7.  Computed by `decide` over ZMod 89 × ZMod 89 (7921 pairs). -/
theorem BSD_E143_card_p89 : (E143_Finset 89).card = 96 := by decide

/-- **`BSD_E143_card_p97`** — 143a1 has exactly **110 affine 𝔽₉₇-points**.
    a₉₇ = 97−110 = −13.  Computed by `decide` over ZMod 97 × ZMod 97 (9409 pairs). -/
theorem BSD_E143_card_p97 : (E143_Finset 97).card = 110 := by decide

/-! ## §2. Exact a_p values -/

/-- **`BSD_ap_p83`** — `a_p 83 = 0`.  From a_p 83 = 83 − 83. -/
theorem BSD_ap_p83 : a_p 83 = (0 : ℤ) := by
  have h := BSD_E143_card_p83; unfold a_p; omega

/-- **`BSD_ap_p89`** — `a_p 89 = −7`.  From a_p 89 = 89 − 96. -/
theorem BSD_ap_p89 : a_p 89 = (-7 : ℤ) := by
  have h := BSD_E143_card_p89; unfold a_p; omega

/-- **`BSD_ap_p97`** — `a_p 97 = −13`.  From a_p 97 = 97 − 110. -/
theorem BSD_ap_p97 : a_p 97 = (-13 : ℤ) := by
  have h := BSD_E143_card_p97; unfold a_p; omega

/-! ## §3. Degree non-negativity — BSD_FrobeniusDegreeNonneg_OPEN p

For each prime, `BSD_FrobeniusDegreeNonneg_OPEN p = ∀ r:ℝ, r²−(a_p p:ℝ)·r+(p:ℝ) ≥ 0`.
The `key` lemma exhibits the completed-square form; `linarith [sq_nonneg ...]` closes
the goal.  All three discriminants are strictly negative. -/

/-- **`BSD_DegreeNonneg_p83`** — `BSD_FrobeniusDegreeNonneg_OPEN 83`.
    r²+0r+83 = r²+83.  Discriminant = 0−332 = −332 < 0. -/
theorem BSD_DegreeNonneg_p83 : BSD_FrobeniusDegreeNonneg_OPEN 83 := fun r => by
  have hap : (a_p 83 : ℝ) = 0 := by exact_mod_cast BSD_ap_p83
  have key : r ^ 2 - (a_p 83 : ℝ) * r + ((83 : ℕ) : ℝ) = r ^ 2 + 83 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg r]

/-- **`BSD_DegreeNonneg_p89`** — `BSD_FrobeniusDegreeNonneg_OPEN 89`.
    r²+7r+89 = (r+7/2)²+307/4.  Discriminant = 49−356 = −307 < 0. -/
theorem BSD_DegreeNonneg_p89 : BSD_FrobeniusDegreeNonneg_OPEN 89 := fun r => by
  have hap : (a_p 89 : ℝ) = -7 := by exact_mod_cast BSD_ap_p89
  have key : r ^ 2 - (a_p 89 : ℝ) * r + ((89 : ℕ) : ℝ) = (r + 7 / 2) ^ 2 + 307 / 4 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r + 7 / 2)]

/-- **`BSD_DegreeNonneg_p97`** — `BSD_FrobeniusDegreeNonneg_OPEN 97`.
    r²+13r+97 = (r+13/2)²+219/4.  Discriminant = 169−388 = −219 < 0. -/
theorem BSD_DegreeNonneg_p97 : BSD_FrobeniusDegreeNonneg_OPEN 97 := fun r => by
  have hap : (a_p 97 : ℝ) = -13 := by exact_mod_cast BSD_ap_p97
  have key : r ^ 2 - (a_p 97 : ℝ) * r + ((97 : ℕ) : ℝ) = (r + 13 / 2) ^ 2 + 219 / 4 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r + 13 / 2)]

/-! ## §4. BSD_Hasse_OPEN — unconditional, via §V.5 bridge

Each theorem is proved by applying `BSD_hasse_of_degree_nonneg` (genesis-733, §V.5)
to the degree non-negativity from §3. -/

/-- **`BSD_Hasse_OPEN_p83`** — `BSD_Hasse_OPEN 83`: |a₈₃(E₁₄₃)| ≤ 2√83.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p83 : BSD_Hasse_OPEN 83 :=
  BSD_hasse_of_degree_nonneg 83 BSD_DegreeNonneg_p83

/-- **`BSD_Hasse_OPEN_p89`** — `BSD_Hasse_OPEN 89`: |a₈₉(E₁₄₃)| ≤ 2√89.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p89 : BSD_Hasse_OPEN 89 :=
  BSD_hasse_of_degree_nonneg 89 BSD_DegreeNonneg_p89

/-- **`BSD_Hasse_OPEN_p97`** — `BSD_Hasse_OPEN 97`: |a₉₇(E₁₄₃)| ≤ 2√97.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p97 : BSD_Hasse_OPEN 97 :=
  BSD_hasse_of_degree_nonneg 97 BSD_DegreeNonneg_p97

end Towers.BSD
