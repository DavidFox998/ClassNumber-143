/-
================================================================
Towers / BSD / BSD_Genesis742_CLOSED  (genesis-742)

**HasseBridge extension: Unconditional Hasse bounds for p ∈ {127, 131, 137, 139, 149}**
via the §V.5 Frobenius-degree discriminant route.

Curve model [0,−1,1,−1,−2]:  y² + y = x³ − x² − x − 2
(same model as all previous genesis files; a₁=0, a₂=−1, a₃=1, a₄=−1, a₆=−2).

### What is proved here (0 sorry, classical trio)

For each prime p in {127, 131, 137, 139, 149} (all good reduction for 143a1;
p ∤ 143 = 11×13):

  Step 1. `BSD_E143_card_pN` — `(E143_Finset p).card = k`
          Proved by `decide` over ZMod p × ZMod p.
          Point counts (affine):
            p=127: card=135,  a₁₂₇ = 127−135 =  −8  (16129 pairs)
            p=131: card=113,  a₁₃₁ = 131−113 = +18  (17161 pairs)
            p=137: card=154,  a₁₃₇ = 137−154 = −17  (18769 pairs)
            p=139: card=121,  a₁₃₉ = 139−121 = +18  (19321 pairs)
            p=149: card=135,  a₁₄₉ = 149−135 = +14  (22201 pairs)

  Step 2. `BSD_ap_pN` — exact integer a_p value (= p − card) by omega.

  Step 3. `BSD_DegreeNonneg_pN` — `BSD_FrobeniusDegreeNonneg_OPEN p`
          Completed-square witnesses (discriminant = a_p²−4p < 0 in all cases):
            p=127:  r²+ 8r+127 = (r+  4)²+111     disc =   64−508 = −444 < 0
            p=131:  r²−18r+131 = (r−  9)²+ 50     disc =  324−524 = −200 < 0
            p=137:  r²+17r+137 = (r+17/2)²+259/4  disc =  289−548 = −259 < 0  (half-int)
            p=139:  r²−18r+139 = (r−  9)²+ 58     disc =  324−556 = −232 < 0
            p=149:  r²−14r+149 = (r−  7)²+100     disc =  196−596 = −400 < 0

  Step 4. `BSD_Hasse_OPEN_pN` — `BSD_Hasse_OPEN p`
          Via `BSD_hasse_of_degree_nonneg` bridge (genesis-733, §V.5 skeleton).

### HasseBridge coverage after genesis-742
  {2,3,5,7} (genesis-734) ∪ {17,19,23,29} (genesis-736) ∪
  {31,37,41,43,47,53,59,61,67} (genesis-738) ∪
  {71,73,79} (genesis-739) ∪ {83,89,97} (genesis-740) ∪
  {101,103,107,109,113} (genesis-741) ∪
  {127,131,137,139,149} (genesis-742) = **33 good primes** covered.

### Honest scope
  - BSD_HasseFull_143_OPEN remains OPEN.
  - Named OPEN primary surfaces: 4 (unchanged — all 5 new closures secondary).
  - NOT a brick.  NOT registered in BRICKS[].  No Clay claim.
  - Requires workflow compilation (decide over 16129–22201 pairs per prime).

Axiom footprint: classical trio {propext, Classical.choice, Quot.sound}.
================================================================
-/

import Towers.BSD.BSD_Genesis741_CLOSED

set_option maxRecDepth 10000
set_option maxHeartbeats 800000

namespace Towers.BSD

/-! ## Fact instances for the five new primes -/

private instance instFactPrime127 : Fact (127 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime131 : Fact (131 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime137 : Fact (137 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime139 : Fact (139 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime149 : Fact (149 : ℕ).Prime := ⟨by norm_num⟩

/-! ## §1. Point counts over 𝔽_p  (by decide) -/

/-- **`BSD_E143_card_p127`** — 143a1 has exactly **135 affine 𝔽₁₂₇-points**.
    a₁₂₇ = 127−135 = −8.  Computed by `decide` over ZMod 127 × ZMod 127 (16129 pairs).
    Curve: y²+y = x³−x²−x−2 (model [0,−1,1,−1,−2]). -/
theorem BSD_E143_card_p127 : (E143_Finset 127).card = 135 := by decide

/-- **`BSD_E143_card_p131`** — 143a1 has exactly **113 affine 𝔽₁₃₁-points**.
    a₁₃₁ = 131−113 = +18.  Computed by `decide` over ZMod 131 × ZMod 131 (17161 pairs). -/
theorem BSD_E143_card_p131 : (E143_Finset 131).card = 113 := by decide

/-- **`BSD_E143_card_p137`** — 143a1 has exactly **154 affine 𝔽₁₃₇-points**.
    a₁₃₇ = 137−154 = −17.  Computed by `decide` over ZMod 137 × ZMod 137 (18769 pairs). -/
theorem BSD_E143_card_p137 : (E143_Finset 137).card = 154 := by decide

/-- **`BSD_E143_card_p139`** — 143a1 has exactly **121 affine 𝔽₁₃₉-points**.
    a₁₃₉ = 139−121 = +18.  Computed by `decide` over ZMod 139 × ZMod 139 (19321 pairs). -/
theorem BSD_E143_card_p139 : (E143_Finset 139).card = 121 := by decide

/-- **`BSD_E143_card_p149`** — 143a1 has exactly **135 affine 𝔽₁₄₉-points**.
    a₁₄₉ = 149−135 = +14.  Computed by `decide` over ZMod 149 × ZMod 149 (22201 pairs). -/
theorem BSD_E143_card_p149 : (E143_Finset 149).card = 135 := by decide

/-! ## §2. Exact a_p values -/

/-- **`BSD_ap_p127`** — `a_p 127 = −8`.  From a_p 127 = 127 − 135. -/
theorem BSD_ap_p127 : a_p 127 = (-8 : ℤ) := by
  have h := BSD_E143_card_p127; unfold a_p; omega

/-- **`BSD_ap_p131`** — `a_p 131 = +18`.  From a_p 131 = 131 − 113. -/
theorem BSD_ap_p131 : a_p 131 = (18 : ℤ) := by
  have h := BSD_E143_card_p131; unfold a_p; omega

/-- **`BSD_ap_p137`** — `a_p 137 = −17`.  From a_p 137 = 137 − 154. -/
theorem BSD_ap_p137 : a_p 137 = (-17 : ℤ) := by
  have h := BSD_E143_card_p137; unfold a_p; omega

/-- **`BSD_ap_p139`** — `a_p 139 = +18`.  From a_p 139 = 139 − 121. -/
theorem BSD_ap_p139 : a_p 139 = (18 : ℤ) := by
  have h := BSD_E143_card_p139; unfold a_p; omega

/-- **`BSD_ap_p149`** — `a_p 149 = +14`.  From a_p 149 = 149 − 135. -/
theorem BSD_ap_p149 : a_p 149 = (14 : ℤ) := by
  have h := BSD_E143_card_p149; unfold a_p; omega

/-! ## §3. Degree non-negativity — BSD_FrobeniusDegreeNonneg_OPEN p -/

/-- **`BSD_DegreeNonneg_p127`** — `BSD_FrobeniusDegreeNonneg_OPEN 127`.
    r²+8r+127 = (r+4)²+111.  Discriminant = 64−508 = −444 < 0. -/
theorem BSD_DegreeNonneg_p127 : BSD_FrobeniusDegreeNonneg_OPEN 127 := fun r => by
  have hap : (a_p 127 : ℝ) = -8 := by exact_mod_cast BSD_ap_p127
  have key : r ^ 2 - (a_p 127 : ℝ) * r + ((127 : ℕ) : ℝ) = (r + 4) ^ 2 + 111 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r + 4)]

/-- **`BSD_DegreeNonneg_p131`** — `BSD_FrobeniusDegreeNonneg_OPEN 131`.
    r²−18r+131 = (r−9)²+50.  Discriminant = 324−524 = −200 < 0. -/
theorem BSD_DegreeNonneg_p131 : BSD_FrobeniusDegreeNonneg_OPEN 131 := fun r => by
  have hap : (a_p 131 : ℝ) = 18 := by exact_mod_cast BSD_ap_p131
  have key : r ^ 2 - (a_p 131 : ℝ) * r + ((131 : ℕ) : ℝ) = (r - 9) ^ 2 + 50 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r - 9)]

/-- **`BSD_DegreeNonneg_p137`** — `BSD_FrobeniusDegreeNonneg_OPEN 137`.
    r²+17r+137 = (r+17/2)²+259/4.  Discriminant = 289−548 = −259 < 0.
    Half-integer witness (a₁₃₇ = −17 is odd). -/
theorem BSD_DegreeNonneg_p137 : BSD_FrobeniusDegreeNonneg_OPEN 137 := fun r => by
  have hap : (a_p 137 : ℝ) = -17 := by exact_mod_cast BSD_ap_p137
  have key : r ^ 2 - (a_p 137 : ℝ) * r + ((137 : ℕ) : ℝ) = (r + 17 / 2) ^ 2 + 259 / 4 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r + 17 / 2)]

/-- **`BSD_DegreeNonneg_p139`** — `BSD_FrobeniusDegreeNonneg_OPEN 139`.
    r²−18r+139 = (r−9)²+58.  Discriminant = 324−556 = −232 < 0. -/
theorem BSD_DegreeNonneg_p139 : BSD_FrobeniusDegreeNonneg_OPEN 139 := fun r => by
  have hap : (a_p 139 : ℝ) = 18 := by exact_mod_cast BSD_ap_p139
  have key : r ^ 2 - (a_p 139 : ℝ) * r + ((139 : ℕ) : ℝ) = (r - 9) ^ 2 + 58 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r - 9)]

/-- **`BSD_DegreeNonneg_p149`** — `BSD_FrobeniusDegreeNonneg_OPEN 149`.
    r²−14r+149 = (r−7)²+100.  Discriminant = 196−596 = −400 < 0. -/
theorem BSD_DegreeNonneg_p149 : BSD_FrobeniusDegreeNonneg_OPEN 149 := fun r => by
  have hap : (a_p 149 : ℝ) = 14 := by exact_mod_cast BSD_ap_p149
  have key : r ^ 2 - (a_p 149 : ℝ) * r + ((149 : ℕ) : ℝ) = (r - 7) ^ 2 + 100 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r - 7)]

/-! ## §4. BSD_Hasse_OPEN — unconditional, via §V.5 bridge -/

/-- **`BSD_Hasse_OPEN_p127`** — `BSD_Hasse_OPEN 127`: |a₁₂₇(E₁₄₃)| ≤ 2√127.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p127 : BSD_Hasse_OPEN 127 :=
  BSD_hasse_of_degree_nonneg 127 BSD_DegreeNonneg_p127

/-- **`BSD_Hasse_OPEN_p131`** — `BSD_Hasse_OPEN 131`: |a₁₃₁(E₁₄₃)| ≤ 2√131.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p131 : BSD_Hasse_OPEN 131 :=
  BSD_hasse_of_degree_nonneg 131 BSD_DegreeNonneg_p131

/-- **`BSD_Hasse_OPEN_p137`** — `BSD_Hasse_OPEN 137`: |a₁₃₇(E₁₄₃)| ≤ 2√137.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p137 : BSD_Hasse_OPEN 137 :=
  BSD_hasse_of_degree_nonneg 137 BSD_DegreeNonneg_p137

/-- **`BSD_Hasse_OPEN_p139`** — `BSD_Hasse_OPEN 139`: |a₁₃₉(E₁₄₃)| ≤ 2√139.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p139 : BSD_Hasse_OPEN 139 :=
  BSD_hasse_of_degree_nonneg 139 BSD_DegreeNonneg_p139

/-- **`BSD_Hasse_OPEN_p149`** — `BSD_Hasse_OPEN 149`: |a₁₄₉(E₁₄₃)| ≤ 2√149.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p149 : BSD_Hasse_OPEN 149 :=
  BSD_hasse_of_degree_nonneg 149 BSD_DegreeNonneg_p149

end Towers.BSD
