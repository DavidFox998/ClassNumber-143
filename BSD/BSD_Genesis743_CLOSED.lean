/-
================================================================
Towers / BSD / BSD_Genesis743_CLOSED  (genesis-743)

**HasseBridge extension: Unconditional Hasse bounds for p ∈ {151,157,163,167,173,179,181,191}**
via the §V.5 Frobenius-degree discriminant route.

Curve model [0,−1,1,−1,−2]:  y² + y = x³ − x² − x − 2
(same model as all previous genesis files; a₁=0, a₂=−1, a₃=1, a₄=−1, a₆=−2).

### S4 completion note

p = 191 is the fourth S4 exceptional prime (S4 = {2,3,19,191}).  After this file:
  - p=2,3   proved in genesis-734 (§V.5 bridge)
  - p=19    proved in genesis-736 (§V.5 bridge)
  - p=191   proved here             (§V.5 bridge)
All four S4 primes now carry unconditional BSD_Hasse_OPEN certificates via the
direct decide → omega → completed-square → BSD_hasse_of_degree_nonneg route.

### What is proved here (0 sorry, classical trio)

For each prime p in {151,157,163,167,173,179,181,191} (all good reduction for
143a1; p ∤ 143 = 11×13):

  Step 1. `BSD_E143_card_pN` — `(E143_Finset p).card = k`
          Proved by `decide` over ZMod p × ZMod p.
          Point counts (affine):
            p=151: card=147,  a₁₅₁ = 151−147 =  +4  (22801 pairs)
            p=157: card=152,  a₁₅₇ = 157−152 =  +5  (24649 pairs)
            p=163: card=167,  a₁₆₃ = 163−167 =  −4  (26569 pairs)
            p=167: card=163,  a₁₆₇ = 167−163 =  +4  (27889 pairs)
            p=173: card=181,  a₁₇₃ = 173−181 =  −8  (29929 pairs)
            p=179: card=194,  a₁₇₉ = 179−194 = −15  (32041 pairs)
            p=181: card=174,  a₁₈₁ = 181−174 =  +7  (32761 pairs)
            p=191: card=206,  a₁₉₁ = 191−206 = −15  (36481 pairs)

  Step 2. `BSD_ap_pN` — exact integer a_p value (= p − card) by omega.

  Step 3. `BSD_DegreeNonneg_pN` — `BSD_FrobeniusDegreeNonneg_OPEN p`
          Completed-square witnesses (discriminant = a_p²−4p < 0 in all cases):
            p=151: r²− 4r+151 = (r−  2)²+147     disc =   16−604 = −588 < 0
            p=157: r²− 5r+157 = (r−5/2)²+603/4   disc =   25−628 = −603 < 0  (half-int)
            p=163: r²+ 4r+163 = (r+  2)²+159     disc =   16−652 = −636 < 0
            p=167: r²− 4r+167 = (r−  2)²+163     disc =   16−668 = −652 < 0
            p=173: r²+ 8r+173 = (r+  4)²+157     disc =   64−692 = −628 < 0
            p=179: r²+15r+179 = (r+15/2)²+491/4  disc =  225−716 = −491 < 0  (half-int)
            p=181: r²− 7r+181 = (r−7/2)²+675/4   disc =   49−724 = −675 < 0  (half-int)
            p=191: r²+15r+191 = (r+15/2)²+539/4  disc =  225−764 = −539 < 0  (half-int)

  Step 4. `BSD_Hasse_OPEN_pN` — `BSD_Hasse_OPEN p`
          Via `BSD_hasse_of_degree_nonneg` bridge (genesis-733, §V.5 skeleton).

### HasseBridge coverage after genesis-743
  {2,3,5,7} (genesis-734) ∪ {17,19,23,29} (genesis-736) ∪
  {31,37,41,43,47,53,59,61,67} (genesis-738) ∪
  {71,73,79} (genesis-739) ∪ {83,89,97} (genesis-740) ∪
  {101,103,107,109,113} (genesis-741) ∪
  {127,131,137,139,149} (genesis-742) ∪
  {151,157,163,167,173,179,181,191} (genesis-743) = **41 good primes** covered.

### Honest scope
  - BSD_HasseFull_143_OPEN remains OPEN (requires all primes, Frobenius API absent).
  - Named OPEN primary surfaces: 4 (unchanged — all 8 new closures secondary).
  - NOT a brick.  NOT registered in BRICKS[].  No Clay claim.
  - Requires workflow compilation (decide over 22801–36481 pairs per prime).

Axiom footprint: classical trio {propext, Classical.choice, Quot.sound}.
================================================================
-/

import Towers.BSD.BSD_Genesis742_CLOSED

set_option maxRecDepth 10000
set_option maxHeartbeats 800000

namespace Towers.BSD

/-! ## Fact instances for the eight new primes -/

private instance instFactPrime151 : Fact (151 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime157 : Fact (157 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime163 : Fact (163 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime167 : Fact (167 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime173 : Fact (173 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime179 : Fact (179 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime181 : Fact (181 : ℕ).Prime := ⟨by norm_num⟩
private instance instFactPrime191 : Fact (191 : ℕ).Prime := ⟨by norm_num⟩

/-! ## §1. Point counts over 𝔽_p  (by decide) -/

/-- **`BSD_E143_card_p151`** — 143a1 has exactly **147 affine 𝔽₁₅₁-points**.
    a₁₅₁ = 151−147 = +4.  Computed by `decide` over ZMod 151 × ZMod 151 (22801 pairs).
    Curve: y²+y = x³−x²−x−2 (model [0,−1,1,−1,−2]). -/
theorem BSD_E143_card_p151 : (E143_Finset 151).card = 147 := by decide

/-- **`BSD_E143_card_p157`** — 143a1 has exactly **152 affine 𝔽₁₅₇-points**.
    a₁₅₇ = 157−152 = +5.  Computed by `decide` over ZMod 157 × ZMod 157 (24649 pairs). -/
theorem BSD_E143_card_p157 : (E143_Finset 157).card = 152 := by decide

/-- **`BSD_E143_card_p163`** — 143a1 has exactly **167 affine 𝔽₁₆₃-points**.
    a₁₆₃ = 163−167 = −4.  Computed by `decide` over ZMod 163 × ZMod 163 (26569 pairs). -/
theorem BSD_E143_card_p163 : (E143_Finset 163).card = 167 := by decide

/-- **`BSD_E143_card_p167`** — 143a1 has exactly **163 affine 𝔽₁₆₇-points**.
    a₁₆₇ = 167−163 = +4.  Computed by `decide` over ZMod 167 × ZMod 167 (27889 pairs). -/
theorem BSD_E143_card_p167 : (E143_Finset 167).card = 163 := by decide

/-- **`BSD_E143_card_p173`** — 143a1 has exactly **181 affine 𝔽₁₇₃-points**.
    a₁₇₃ = 173−181 = −8.  Computed by `decide` over ZMod 173 × ZMod 173 (29929 pairs). -/
theorem BSD_E143_card_p173 : (E143_Finset 173).card = 181 := by decide

/-- **`BSD_E143_card_p179`** — 143a1 has exactly **194 affine 𝔽₁₇₉-points**.
    a₁₇₉ = 179−194 = −15.  Computed by `decide` over ZMod 179 × ZMod 179 (32041 pairs). -/
theorem BSD_E143_card_p179 : (E143_Finset 179).card = 194 := by decide

/-- **`BSD_E143_card_p181`** — 143a1 has exactly **174 affine 𝔽₁₈₁-points**.
    a₁₈₁ = 181−174 = +7.  Computed by `decide` over ZMod 181 × ZMod 181 (32761 pairs). -/
theorem BSD_E143_card_p181 : (E143_Finset 181).card = 174 := by decide

/-- **`BSD_E143_card_p191`** — 143a1 has exactly **206 affine 𝔽₁₉₁-points**.
    a₁₉₁ = 191−206 = −15.  Computed by `decide` over ZMod 191 × ZMod 191 (36481 pairs).
    S4 prime: a₁₉₁ = −15 matches LMFDB 143.2.a.a and BSD_ap191_card_EMPIRICAL. -/
theorem BSD_E143_card_p191 : (E143_Finset 191).card = 206 := by decide

/-! ## §2. Exact a_p values -/

/-- **`BSD_ap_p151`** — `a_p 151 = +4`.  From a_p 151 = 151 − 147. -/
theorem BSD_ap_p151 : a_p 151 = (4 : ℤ) := by
  have h := BSD_E143_card_p151; unfold a_p; omega

/-- **`BSD_ap_p157`** — `a_p 157 = +5`.  From a_p 157 = 157 − 152. -/
theorem BSD_ap_p157 : a_p 157 = (5 : ℤ) := by
  have h := BSD_E143_card_p157; unfold a_p; omega

/-- **`BSD_ap_p163`** — `a_p 163 = −4`.  From a_p 163 = 163 − 167. -/
theorem BSD_ap_p163 : a_p 163 = (-4 : ℤ) := by
  have h := BSD_E143_card_p163; unfold a_p; omega

/-- **`BSD_ap_p167`** — `a_p 167 = +4`.  From a_p 167 = 167 − 163. -/
theorem BSD_ap_p167 : a_p 167 = (4 : ℤ) := by
  have h := BSD_E143_card_p167; unfold a_p; omega

/-- **`BSD_ap_p173`** — `a_p 173 = −8`.  From a_p 173 = 173 − 181. -/
theorem BSD_ap_p173 : a_p 173 = (-8 : ℤ) := by
  have h := BSD_E143_card_p173; unfold a_p; omega

/-- **`BSD_ap_p179`** — `a_p 179 = −15`.  From a_p 179 = 179 − 194. -/
theorem BSD_ap_p179 : a_p 179 = (-15 : ℤ) := by
  have h := BSD_E143_card_p179; unfold a_p; omega

/-- **`BSD_ap_p181`** — `a_p 181 = +7`.  From a_p 181 = 181 − 174. -/
theorem BSD_ap_p181 : a_p 181 = (7 : ℤ) := by
  have h := BSD_E143_card_p181; unfold a_p; omega

/-- **`BSD_ap_p191`** — `a_p 191 = −15`.  From a_p 191 = 191 − 206.
    S4 prime: matches BSD_ap191_card_EMPIRICAL (now confirmed unconditional). -/
theorem BSD_ap_p191 : a_p 191 = (-15 : ℤ) := by
  have h := BSD_E143_card_p191; unfold a_p; omega

/-! ## §3. Degree non-negativity — BSD_FrobeniusDegreeNonneg_OPEN p -/

/-- **`BSD_DegreeNonneg_p151`** — `BSD_FrobeniusDegreeNonneg_OPEN 151`.
    r²−4r+151 = (r−2)²+147.  Discriminant = 16−604 = −588 < 0. -/
theorem BSD_DegreeNonneg_p151 : BSD_FrobeniusDegreeNonneg_OPEN 151 := fun r => by
  have hap : (a_p 151 : ℝ) = 4 := by exact_mod_cast BSD_ap_p151
  have key : r ^ 2 - (a_p 151 : ℝ) * r + ((151 : ℕ) : ℝ) = (r - 2) ^ 2 + 147 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r - 2)]

/-- **`BSD_DegreeNonneg_p157`** — `BSD_FrobeniusDegreeNonneg_OPEN 157`.
    r²−5r+157 = (r−5/2)²+603/4.  Discriminant = 25−628 = −603 < 0.
    Half-integer witness (a₁₅₇ = +5 is odd). -/
theorem BSD_DegreeNonneg_p157 : BSD_FrobeniusDegreeNonneg_OPEN 157 := fun r => by
  have hap : (a_p 157 : ℝ) = 5 := by exact_mod_cast BSD_ap_p157
  have key : r ^ 2 - (a_p 157 : ℝ) * r + ((157 : ℕ) : ℝ) = (r - 5 / 2) ^ 2 + 603 / 4 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r - 5 / 2)]

/-- **`BSD_DegreeNonneg_p163`** — `BSD_FrobeniusDegreeNonneg_OPEN 163`.
    r²+4r+163 = (r+2)²+159.  Discriminant = 16−652 = −636 < 0. -/
theorem BSD_DegreeNonneg_p163 : BSD_FrobeniusDegreeNonneg_OPEN 163 := fun r => by
  have hap : (a_p 163 : ℝ) = -4 := by exact_mod_cast BSD_ap_p163
  have key : r ^ 2 - (a_p 163 : ℝ) * r + ((163 : ℕ) : ℝ) = (r + 2) ^ 2 + 159 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r + 2)]

/-- **`BSD_DegreeNonneg_p167`** — `BSD_FrobeniusDegreeNonneg_OPEN 167`.
    r²−4r+167 = (r−2)²+163.  Discriminant = 16−668 = −652 < 0. -/
theorem BSD_DegreeNonneg_p167 : BSD_FrobeniusDegreeNonneg_OPEN 167 := fun r => by
  have hap : (a_p 167 : ℝ) = 4 := by exact_mod_cast BSD_ap_p167
  have key : r ^ 2 - (a_p 167 : ℝ) * r + ((167 : ℕ) : ℝ) = (r - 2) ^ 2 + 163 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r - 2)]

/-- **`BSD_DegreeNonneg_p173`** — `BSD_FrobeniusDegreeNonneg_OPEN 173`.
    r²+8r+173 = (r+4)²+157.  Discriminant = 64−692 = −628 < 0. -/
theorem BSD_DegreeNonneg_p173 : BSD_FrobeniusDegreeNonneg_OPEN 173 := fun r => by
  have hap : (a_p 173 : ℝ) = -8 := by exact_mod_cast BSD_ap_p173
  have key : r ^ 2 - (a_p 173 : ℝ) * r + ((173 : ℕ) : ℝ) = (r + 4) ^ 2 + 157 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r + 4)]

/-- **`BSD_DegreeNonneg_p179`** — `BSD_FrobeniusDegreeNonneg_OPEN 179`.
    r²+15r+179 = (r+15/2)²+491/4.  Discriminant = 225−716 = −491 < 0.
    Half-integer witness (a₁₇₉ = −15 is odd). -/
theorem BSD_DegreeNonneg_p179 : BSD_FrobeniusDegreeNonneg_OPEN 179 := fun r => by
  have hap : (a_p 179 : ℝ) = -15 := by exact_mod_cast BSD_ap_p179
  have key : r ^ 2 - (a_p 179 : ℝ) * r + ((179 : ℕ) : ℝ) = (r + 15 / 2) ^ 2 + 491 / 4 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r + 15 / 2)]

/-- **`BSD_DegreeNonneg_p181`** — `BSD_FrobeniusDegreeNonneg_OPEN 181`.
    r²−7r+181 = (r−7/2)²+675/4.  Discriminant = 49−724 = −675 < 0.
    Half-integer witness (a₁₈₁ = +7 is odd). -/
theorem BSD_DegreeNonneg_p181 : BSD_FrobeniusDegreeNonneg_OPEN 181 := fun r => by
  have hap : (a_p 181 : ℝ) = 7 := by exact_mod_cast BSD_ap_p181
  have key : r ^ 2 - (a_p 181 : ℝ) * r + ((181 : ℕ) : ℝ) = (r - 7 / 2) ^ 2 + 675 / 4 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r - 7 / 2)]

/-- **`BSD_DegreeNonneg_p191`** — `BSD_FrobeniusDegreeNonneg_OPEN 191`.
    r²+15r+191 = (r+15/2)²+539/4.  Discriminant = 225−764 = −539 < 0.
    Half-integer witness (a₁₉₁ = −15 is odd).
    S4 prime: closes BSD_HasseFull route for the fourth S4 exceptional prime. -/
theorem BSD_DegreeNonneg_p191 : BSD_FrobeniusDegreeNonneg_OPEN 191 := fun r => by
  have hap : (a_p 191 : ℝ) = -15 := by exact_mod_cast BSD_ap_p191
  have key : r ^ 2 - (a_p 191 : ℝ) * r + ((191 : ℕ) : ℝ) = (r + 15 / 2) ^ 2 + 539 / 4 := by
    rw [hap]; push_cast; ring
  linarith [sq_nonneg (r + 15 / 2)]

/-! ## §4. BSD_Hasse_OPEN — unconditional, via §V.5 bridge -/

/-- **`BSD_Hasse_OPEN_p151`** — `BSD_Hasse_OPEN 151`: |a₁₅₁(E₁₄₃)| ≤ 2√151.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p151 : BSD_Hasse_OPEN 151 :=
  BSD_hasse_of_degree_nonneg 151 BSD_DegreeNonneg_p151

/-- **`BSD_Hasse_OPEN_p157`** — `BSD_Hasse_OPEN 157`: |a₁₅₇(E₁₄₃)| ≤ 2√157.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p157 : BSD_Hasse_OPEN 157 :=
  BSD_hasse_of_degree_nonneg 157 BSD_DegreeNonneg_p157

/-- **`BSD_Hasse_OPEN_p163`** — `BSD_Hasse_OPEN 163`: |a₁₆₃(E₁₄₃)| ≤ 2√163.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p163 : BSD_Hasse_OPEN 163 :=
  BSD_hasse_of_degree_nonneg 163 BSD_DegreeNonneg_p163

/-- **`BSD_Hasse_OPEN_p167`** — `BSD_Hasse_OPEN 167`: |a₁₆₇(E₁₄₃)| ≤ 2√167.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p167 : BSD_Hasse_OPEN 167 :=
  BSD_hasse_of_degree_nonneg 167 BSD_DegreeNonneg_p167

/-- **`BSD_Hasse_OPEN_p173`** — `BSD_Hasse_OPEN 173`: |a₁₇₃(E₁₄₃)| ≤ 2√173.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p173 : BSD_Hasse_OPEN 173 :=
  BSD_hasse_of_degree_nonneg 173 BSD_DegreeNonneg_p173

/-- **`BSD_Hasse_OPEN_p179`** — `BSD_Hasse_OPEN 179`: |a₁₇₉(E₁₄₃)| ≤ 2√179.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p179 : BSD_Hasse_OPEN 179 :=
  BSD_hasse_of_degree_nonneg 179 BSD_DegreeNonneg_p179

/-- **`BSD_Hasse_OPEN_p181`** — `BSD_Hasse_OPEN 181`: |a₁₈₁(E₁₄₃)| ≤ 2√181.
    UNCONDITIONAL, 0 sorry, classical trio. -/
theorem BSD_Hasse_OPEN_p181 : BSD_Hasse_OPEN 181 :=
  BSD_hasse_of_degree_nonneg 181 BSD_DegreeNonneg_p181

/-- **`BSD_Hasse_OPEN_p191`** — `BSD_Hasse_OPEN 191`: |a₁₉₁(E₁₄₃)| ≤ 2√191.
    UNCONDITIONAL, 0 sorry, classical trio.
    S4 prime: fourth and final S4 exceptional prime in HasseBridge. -/
theorem BSD_Hasse_OPEN_p191 : BSD_Hasse_OPEN 191 :=
  BSD_hasse_of_degree_nonneg 191 BSD_DegreeNonneg_p191

end Towers.BSD
