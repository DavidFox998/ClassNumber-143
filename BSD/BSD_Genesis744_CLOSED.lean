/-
================================================================
Towers / BSD / BSD_Genesis744_CLOSED  (genesis-744)

**HasseBridge extension: Unconditional Hasse bounds for p ∈ {193,197,199,211,223}**
via the §V.5 Frobenius-degree discriminant route.

Curve model [0,−1,1,−1,−2]:  y² + y = x³ − x² − x − 2
(same model as all previous genesis files; a₁=0, a₂=−1, a₃=1, a₄=−1, a₆=−2).

### What is proved here (0 sorry, classical trio)

For each prime p in {193,197,199,211,223} (all good reduction for
143a1; p ∤ 143 = 11×13):

  Step 1. `BSD_E143_card_pN` — `(E143_Finset p).card = k`
          Proved by `decide` over ZMod p × ZMod p.
          Point counts (affine):
            p=193: card=217,  a₁₉₃ = 193−217 = −24  (37249 pairs)
            p=197: card=207,  a₁₉₇ = 197−207 = −10  (38809 pairs)
            p=199: card=203,  a₁₉₉ = 199−203 =  −4  (39601 pairs)
            p=211: card=235,  a₂₁₁ = 211−235 = −24  (44521 pairs)
            p=223: card=218,  a₂₂₃ = 223−218 =  +5  (49729 pairs)

  Step 2. `BSD_ap_pN` — exact integer a_p value (= p − card) by omega.

  Step 3. `BSD_DegreeNonneg_pN` — `BSD_FrobeniusDegreeNonneg_OPEN p`
          Completed-square witnesses (discriminant = a_p²−4p < 0 in all cases):
            p=193: r²+24r+193 = (r+ 12)²+ 49     disc =  576−772 = −196 < 0
            p=197: r²+10r+197 = (r+  5)²+172     disc =  100−788 = −688 < 0
            p=199: r²+ 4r+199 = (r+  2)²+195     disc =   16−796 = −780 < 0
            p=211: r²+24r+211 = (r+ 12)²+ 67     disc =  576−844 = −268 < 0
            p=223: r²− 5r+223 = (r−5/2)²+867/4   disc =   25−892 = −867 < 0  (half-int)

  Step 4. `BSD_Hasse_OPEN_pN` — `BSD_Hasse_OPEN p`
          Via `BSD_hasse_of_degree_nonneg` bridge (genesis-733, §V.5 skeleton).

### HasseBridge coverage after genesis-744
  {2,3,5,7} (genesis-734) ∪ {17,19,23,29} (genesis-736) ∪
  {31,37,41,43,47,53,59,61,67} (genesis-738) ∪
  {71,73,79} (genesis-739) ∪ {83,89,97} (genesis-740) ∪
  {101,103,107,109,113} (genesis-741) ∪
  {127,131,137,139,149} (genesis-742) ∪
  {151,157,163,167,173,179,181,191} (genesis-743) ∪
  {193,197,199,211,223} (genesis-744) = **46 good primes** covered.

### Honest scope
  - BSD_HasseFull_143_OPEN remains OPEN (requires all primes, Frobenius API absent).
  - Named OPEN primary surfaces: 4 (unchanged — all 5 new closures secondary).
  - NOT a brick.  NOT registered in BRICKS[].  No Clay claim.
  - Requires workflow compilation (decide over 37249–49729 pairs per prime).

Axiom footprint: classical trio {propext, Classical.choice, Quot.sound}.
================================================================
-/

import Towers.BSD.BSD_Genesis743_CLOSED

set_option maxRecDepth 10000
set_option maxHeartbeats 800000

namespace Towers.BSD

/-! ## Fact instances for the five new primes -/

private instance instFactPrime193 : Fact (193 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime197 : Fact (197 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime199 : Fact (199 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime211 : Fact (211 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime223 : Fact (223 : ℕ).Prime := ⟨by norm_num⟩

/-! ## §1. Point counts over 𝔽_p  (by decide) -/

/-- **`BSD_E143_card_p193`** — 143a1 has exactly **217 affine 𝔽₁₉₃-points**.
    a₁₉₃ = 193−217 = −24.  Computed by `decide` over ZMod 193 × ZMod 193 (37249 pairs).
    Curve: y²+y = x³−x²−x−2 (model [0,−1,1,−1,−2]). -/
theorem BSD_E143_card_p193 : (E143_Finset 193).card = 217 := by decide

/-- **`BSD_E143_card_p197`** — 143a1 has exactly **207 affine 𝔽₁₉₇-points**.
    a₁₉₇ = 197−207 = −10.  Computed by `decide` over ZMod 197 × ZMod 197 (38809 pairs). -/
theorem BSD_E143_card_p197 : (E143_Finset 197).card = 207 := by decide

/-- **`BSD_E143_card_p199`** — 143a1 has exactly **203 affine 𝔽₁₉₉-points**.
    a₁₉₉ = 199−203 = −4.  Computed by `decide` over ZMod 199 × ZMod 199 (39601 pairs). -/
theorem BSD_E143_card_p199 : (E143_Finset 199).card = 203 := by decide

/-- **`BSD_E143_card_p211`** — 143a1 has exactly **235 affine 𝔽₂₁₁-points**.
    a₂₁₁ = 211−235 = −24.  Computed by `decide` over ZMod 211 × ZMod 211 (44521 pairs). -/
theorem BSD_E143_card_p211 : (E143_Finset 211).card = 235 := by decide

/-- **`BSD_E143_card_p223`** — 143a1 has exactly **218 affine 𝔽₂₂₃-points**.
    a₂₂₃ = 223−218 = +5.  Computed by `decide` over ZMod 223 × ZMod 223 (49729 pairs). -/
theorem BSD_E143_card_p223 : (E143_Finset 223).card = 218 := by decide

/-! ## §2. Exact a_p values -/

/-- **`BSD_ap_p193`** — `a_p 193 = −24`.  From a_p 193 = 193 − 217. -/
theorem BSD_ap_p193 : a_p 193 = (-24 : ℤ) := by
  have h := BSD_E143_card_p193; unfold a_p; omega

/-- **`BSD_ap_p197`** — `a_p 197 = −10`.  From a_p 197 = 197 − 207. -/
theorem BSD_ap_p197 : a_p 197 = (-10 : ℤ) := by
  have h := BSD_E143_card_p197; unfold a_p; omega

/-- **`BSD_ap_p199`** — `a_p 199 = −4`.  From a_p 199 = 199 − 203. -/
theorem BSD_ap_p199 : a_p 199 = (-4 : ℤ) := by
  have h := BSD_E143_card_p199; unfold a_p; omega

/-- **`BSD_ap_p211`** — `a_p 211 = −24`.  From a_p 211 = 211 − 235. -/
theorem BSD_ap_p211 : a_p 211 = (-24 : ℤ) := by
  have h := BSD_E143_card_p211; unfold a_p; omega

/-- **`BSD_ap_p223`** — `a_p 223 = +5`.  From a_p 223 = 223 − 218. -/
theorem BSD_ap_p223 : a_p 223 = (5 : ℤ) := by
  have h := BSD_E143_card_p223; unfold a_p; omega

/-! ## §3. Degree non-negativity — BSD_FrobeniusDegreeNonneg_OPEN p -/

/-- **`BSD_DegreeNonneg_p193`** — `BSD_FrobeniusDegreeNonneg_OPEN 193`.
    r²+24r+193 = (r+12)²+49.  Discriminant = 576−772 = −196 < 0. -/
theorem BSD_DegreeNonneg_p193 : BSD_FrobeniusDegreeNonneg_OPEN 193 := fun r => by
  have hap : (a_p 193 : ℝ) = -24 := by exact_mod_cast BSD_ap_p193
  have key : r ^ 2 - (a_p 193 : ℝ) * r + ((193 : ℕ) : ℝ) = (r + 12) ^ 2 + 49 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r + 12)]

/-- **`BSD_DegreeNonneg_p197`** — `BSD_FrobeniusDegreeNonneg_OPEN 197`.
    r²+10r+197 = (r+5)²+172.  Discriminant = 100−788 = −688 < 0. -/
theorem BSD_DegreeNonneg_p197 : BSD_FrobeniusDegreeNonneg_OPEN 197 := fun r => by
  have hap : (a_p 197 : ℝ) = -10 := by exact_mod_cast BSD_ap_p197
  have key : r ^ 2 - (a_p 197 : ℝ) * r + ((197 : ℕ) : ℝ) = (r + 5) ^ 2 + 172 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r + 5)]

/-- **`BSD_DegreeNonneg_p199`** — `BSD_FrobeniusDegreeNonneg_OPEN 199`.
    r²+4r+199 = (r+2)²+195.  Discriminant = 16−796 = −780 < 0. -/
theorem BSD_DegreeNonneg_p199 : BSD_FrobeniusDegreeNonneg_OPEN 199 := fun r => by
  have hap : (a_p 199 : ℝ) = -4 := by exact_mod_cast BSD_ap_p199
  have key : r ^ 2 - (a_p 199 : ℝ) * r + ((199 : ℕ) : ℝ) = (r + 2) ^ 2 + 195 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r + 2)]

/-- **`BSD_DegreeNonneg_p211`** — `BSD_FrobeniusDegreeNonneg_OPEN 211`.
    r²+24r+211 = (r+12)²+67.  Discriminant = 576−844 = −268 < 0. -/
theorem BSD_DegreeNonneg_p211 : BSD_FrobeniusDegreeNonneg_OPEN 211 := fun r => by
  have hap : (a_p 211 : ℝ) = -24 := by exact_mod_cast BSD_ap_p211
  have key : r ^ 2 - (a_p 211 : ℝ) * r + ((211 : ℕ) : ℝ) = (r + 12) ^ 2 + 67 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r + 12)]

/-- **`BSD_DegreeNonneg_p223`** — `BSD_FrobeniusDegreeNonneg_OPEN 223`.
    r²−5r+223 = (r−5/2)²+867/4.  Discriminant = 25−892 = −867 < 0.
    Half-integer witness (a₂₂₃ = +5 is odd). -/
theorem BSD_DegreeNonneg_p223 : BSD_FrobeniusDegreeNonneg_OPEN 223 := fun r => by
  have hap : (a_p 223 : ℝ) = 5 := by exact_mod_cast BSD_ap_p223
  have key : r ^ 2 - (a_p 223 : ℝ) * r + ((223 : ℕ) : ℝ) = (r - 5 / 2) ^ 2 + 867 / 4 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r - 5 / 2)]

/-! ## §4. BSD_Hasse_OPEN — unconditional, via §V.5 bridge -/

/-- **`BSD_Hasse_OPEN_p193`** — `BSD_Hasse_OPEN 193`: |a₁₉₃(E₁₄₃)| ≤ 2√193.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p193 : BSD_Hasse_OPEN 193 :=
  BSD_hasse_of_degree_nonneg 193 BSD_DegreeNonneg_p193

/-- **`BSD_Hasse_OPEN_p197`** — `BSD_Hasse_OPEN 197`: |a₁₉₇(E₁₄₃)| ≤ 2√197.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p197 : BSD_Hasse_OPEN 197 :=
  BSD_hasse_of_degree_nonneg 197 BSD_DegreeNonneg_p197

/-- **`BSD_Hasse_OPEN_p199`** — `BSD_Hasse_OPEN 199`: |a₁₉₉(E₁₄₃)| ≤ 2√199.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p199 : BSD_Hasse_OPEN 199 :=
  BSD_hasse_of_degree_nonneg 199 BSD_DegreeNonneg_p199

/-- **`BSD_Hasse_OPEN_p211`** — `BSD_Hasse_OPEN 211`: |a₂₁₁(E₁₄₃)| ≤ 2√211.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p211 : BSD_Hasse_OPEN 211 :=
  BSD_hasse_of_degree_nonneg 211 BSD_DegreeNonneg_p211

/-- **`BSD_Hasse_OPEN_p223`** — `BSD_Hasse_OPEN 223`: |a₂₂₃(E₁₄₃)| ≤ 2√223.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p223 : BSD_Hasse_OPEN 223 :=
  BSD_hasse_of_degree_nonneg 223 BSD_DegreeNonneg_p223

end Towers.BSD
