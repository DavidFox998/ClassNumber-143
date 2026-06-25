import Towers.BSD.BSD_ClassNum_Upper_CLOSED
import Towers.BSD.BSD_ClassNumberBounds
import Mathlib.NumberTheory.NumberField.ClassNumber
import Mathlib.RingTheory.ClassGroup
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.RingTheory.Ideal.Norm

/-!
# BSD_ClassNumber_UpperBound_CLOSED

Proves `BSD_classGroupCard_le_10_CLOSED` — classNumber K ≤ 10 —
CONDITIONAL on `BSD_small_norm_in_zpowers_OPEN` (the ideal-case-analysis surface).

## Mathematical content

1. **Witnesses**: α = 3+ω ∈ 𝓞K (N=48=3·2⁴) and β = 4+ω ∈ 𝓞K (N=56=7·2³).

2. **Proved membership** (0 sorry, ring computation with ω²=ω−36):
   - 3+ω ∈ span{3,ω} = p₃_OK
   - 3+ω ∈ p̄₂_OK⁴ via: 3+ω = −83·2⁴ + (−18)·4·(ω−1)² + (−1)·(ω−1)⁴
   - 4+ω ∈ span{7,ω−3} = p₇_OK
   - 4+ω ∈ p₂_OK³  via: 4+ω = 167·2³ + 18·2·ω² + ω³

3. **Named open surfaces**:
   - `BSD_w3_ideal_equality_OPEN`: span{3+ω} = p₃·p̄₂⁴
   - `BSD_w4_ideal_equality_OPEN`: span{4+ω} = p₇·p₂³
   - `BSD_small_norm_in_zpowers_OPEN`: every ideal of norm ≤ 7 has class in ⟨[p₂]⟩

4. **Proved conditionally** (from Minkowski + BSD_small_norm_in_zpowers_OPEN):
   `classNumber K ≤ 10`

SORRY: 0.  Axiom footprint: classical trio `{propext, Classical.choice, Quot.sound}`.
-/

set_option maxHeartbeats 800000

namespace Towers.BSD

open NumberField

-- ============================================================
-- §1. Additional prime ideal definitions
-- ============================================================

/-- p̄₂_OK := span{2, ω−1} — the conjugate prime above 2. absNorm = 2. -/
noncomputable def pbar2_OK : Ideal (𝓞 K) := Ideal.span {(2 : 𝓞 K), nω_OK - 1}

/-- p₃_OK := span{3, ω} — the prime above 3. absNorm = 3. -/
noncomputable def p3_OK : Ideal (𝓞 K) := Ideal.span {(3 : 𝓞 K), nω_OK}

/-- p₇_OK := span{7, ω−3} — a prime above 7. absNorm = 7. -/
noncomputable def p7_OK : Ideal (𝓞 K) := Ideal.span {(7 : 𝓞 K), nω_OK - 3}

-- ============================================================
-- §2. Generator membership
-- ============================================================

private theorem two_mem_pbar2_OK : (2 : 𝓞 K) ∈ pbar2_OK :=
  Ideal.subset_span (Set.mem_insert _ _)

private theorem omm1_mem_pbar2_OK : nω_OK - 1 ∈ pbar2_OK :=
  Ideal.subset_span (Set.mem_insert_iff.mpr (Or.inr rfl))

private theorem three_mem_p3_OK : (3 : 𝓞 K) ∈ p3_OK :=
  Ideal.subset_span (Set.mem_insert _ _)

private theorem nω_mem_p3_OK : nω_OK ∈ p3_OK :=
  Ideal.subset_span (Set.mem_insert_iff.mpr (Or.inr rfl))

private theorem seven_mem_p7_OK : (7 : 𝓞 K) ∈ p7_OK :=
  Ideal.subset_span (Set.mem_insert _ _)

private theorem omm3_mem_p7_OK : nω_OK - 3 ∈ p7_OK :=
  Ideal.subset_span (Set.mem_insert_iff.mpr (Or.inr rfl))

private theorem two_mem_p2_OK : (2 : 𝓞 K) ∈ p2_OK :=
  Ideal.subset_span (Set.mem_insert _ _)

private theorem nω_mem_p2_OK : nω_OK ∈ p2_OK :=
  Ideal.subset_span (Set.mem_insert_iff.mpr (Or.inr rfl))

-- ============================================================
-- §3. Core relation: nω_OK² = nω_OK − 36 in 𝓞K
-- ============================================================

/-- ω² = ω − 36 lifted to 𝓞K (from the minimal polynomial ω²−ω+36=0). -/
private theorem nω_sq_eq : nω_OK ^ 2 = nω_OK - 36 := by
  apply_fun (algebraMap (𝓞 K) K)
  simp only [map_pow, map_sub, map_ofNat, nω_OK_coe, map_ofNat]
  linear_combination ω_sq_eq_BSD

-- ============================================================
-- §4. Witness: 3+ω ∈ p₃_OK
-- ============================================================

/-- 3+ω ∈ span{3, ω}: trivial — it is 1·3 + 1·ω. -/
theorem w3_mem_p3_OK : (3 : 𝓞 K) + nω_OK ∈ p3_OK :=
  Ideal.add_mem _ (Ideal.mul_mem_left _ 1 three_mem_p3_OK)
                  (Ideal.mul_mem_left _ 1 nω_mem_p3_OK)

-- ============================================================
-- §5. Witness: 3+ω ∈ p̄₂_OK⁴
-- ============================================================

/-- Algebraic identity: 3+ω = −83·2⁴ + (−18)·4·(ω−1)² + (−1)·(ω−1)⁴.
    Verification: LHS−RHS = (ω²−ω+36)·(ω²−3ω+39) = 0 in 𝓞K. -/
private theorem w3_decomp :
    (3 : 𝓞 K) + nω_OK =
    (-83 : 𝓞 K) * (2 : 𝓞 K) ^ 4 +
    (-18 : 𝓞 K) * ((4 : 𝓞 K) * (nω_OK - 1) ^ 2) +
    (-1 : 𝓞 K) * (nω_OK - 1) ^ 4 := by
  linear_combination (nω_OK ^ 2 - 3 * nω_OK + 39 : 𝓞 K) * nω_sq_eq

private theorem two_pow4_mem_pbar2_pow4 : (2 : 𝓞 K) ^ 4 ∈ pbar2_OK ^ 4 :=
  Ideal.pow_mem_pow two_mem_pbar2_OK 4

private theorem omm1_pow4_mem_pbar2_pow4 : (nω_OK - 1) ^ 4 ∈ pbar2_OK ^ 4 :=
  Ideal.pow_mem_pow omm1_mem_pbar2_OK 4

/-- 4·(ω−1)² ∈ p̄₂_OK⁴: since (2·(ω−1))² ∈ (p̄₂²)² = p̄₂⁴. -/
private theorem four_mul_omm1sq_mem_pbar2_pow4 :
    (4 : 𝓞 K) * (nω_OK - 1) ^ 2 ∈ pbar2_OK ^ 4 := by
  have hprod : (2 : 𝓞 K) * (nω_OK - 1) ∈ pbar2_OK ^ 2 := by
    rw [pow_two]; exact Ideal.mul_mem_mul two_mem_pbar2_OK omm1_mem_pbar2_OK
  have hpow : ((2 : 𝓞 K) * (nω_OK - 1)) ^ 2 ∈ (pbar2_OK ^ 2) ^ 2 :=
    Ideal.pow_mem_pow hprod 2
  have heq : (4 : 𝓞 K) * (nω_OK - 1) ^ 2 = ((2 : 𝓞 K) * (nω_OK - 1)) ^ 2 := by ring
  rwa [heq, ← pow_mul]

/-- **w3_mem_pbar2_pow4**: 3+ω ∈ p̄₂_OK⁴ (proved, 0 sorry). -/
theorem w3_mem_pbar2_pow4 : (3 : 𝓞 K) + nω_OK ∈ pbar2_OK ^ 4 := by
  rw [w3_decomp]
  exact Ideal.add_mem _
    (Ideal.add_mem _
      (Ideal.mul_mem_left _ _ two_pow4_mem_pbar2_pow4)
      (Ideal.mul_mem_left _ _ four_mul_omm1sq_mem_pbar2_pow4))
    (Ideal.mul_mem_left _ _ omm1_pow4_mem_pbar2_pow4)

-- ============================================================
-- §6. Witness: 4+ω ∈ p₇_OK
-- ============================================================

/-- 4+ω ∈ span{7, ω−3}: trivially (4+ω) = 1·7 + 1·(ω−3). -/
theorem w4_mem_p7_OK : (4 : 𝓞 K) + nω_OK ∈ p7_OK :=
  Ideal.add_mem _ (Ideal.mul_mem_left _ 1 seven_mem_p7_OK)
                  (Ideal.mul_mem_left _ 1 omm3_mem_p7_OK)

-- ============================================================
-- §7. Witness: 4+ω ∈ p₂_OK³
-- ============================================================

/-- Algebraic identity: 4+ω = 167·2³ + 18·2·ω² + ω³.
    Verification: LHS−RHS = (ω²−ω+36)·(−ω−37) = 0 in 𝓞K. -/
private theorem w4_decomp :
    (4 : 𝓞 K) + nω_OK =
    (167 : 𝓞 K) * (2 : 𝓞 K) ^ 3 +
    (18 : 𝓞 K) * ((2 : 𝓞 K) * nω_OK ^ 2) +
    nω_OK ^ 3 := by
  linear_combination (-nω_OK - 37 : 𝓞 K) * nω_sq_eq

private theorem two_pow3_mem_p2_pow3 : (2 : 𝓞 K) ^ 3 ∈ p2_OK ^ 3 :=
  Ideal.pow_mem_pow two_mem_p2_OK 3

private theorem nω_pow3_mem_p2_pow3 : nω_OK ^ 3 ∈ p2_OK ^ 3 :=
  Ideal.pow_mem_pow nω_mem_p2_OK 3

/-- 2·ω² ∈ p₂_OK³: since ω² ∈ p₂² and 2 ∈ p₂, their product 2·ω² ∈ p₂³. -/
private theorem two_mul_nωsq_mem_p2_pow3 : (2 : 𝓞 K) * nω_OK ^ 2 ∈ p2_OK ^ 3 := by
  have hω2 : nω_OK ^ 2 ∈ p2_OK ^ 2 := Ideal.pow_mem_pow nω_mem_p2_OK 2
  have h2 : (2 : 𝓞 K) ∈ p2_OK ^ 1 := by simp [two_mem_p2_OK]
  calc (2 : 𝓞 K) * nω_OK ^ 2
      ∈ p2_OK ^ 1 * p2_OK ^ 2 := Ideal.mul_mem_mul h2 hω2
    _ = p2_OK ^ 3 := by ring

/-- **w4_mem_p2_pow3**: 4+ω ∈ p₂_OK³ (proved, 0 sorry). -/
theorem w4_mem_p2_pow3 : (4 : 𝓞 K) + nω_OK ∈ p2_OK ^ 3 := by
  rw [w4_decomp]
  exact Ideal.add_mem _
    (Ideal.add_mem _
      (Ideal.mul_mem_left _ _ two_pow3_mem_p2_pow3)
      (Ideal.mul_mem_left _ _ two_mul_nωsq_mem_p2_pow3))
    nω_pow3_mem_p2_pow3

-- ============================================================
-- §8. Span containments via coprimality
-- ============================================================

/-- p₃_OK ⊔ p̄₂_OK⁴ = ⊤.
    Witness: 1 = (−5)·3 + 2⁴.  Numerically: −15 + 16 = 1. -/
private theorem p3_sup_pbar2pow4_eq_top : p3_OK ⊔ pbar2_OK ^ 4 = ⊤ := by
  rw [Ideal.eq_top_iff_one]
  have h3 : (-5 : 𝓞 K) * 3 ∈ p3_OK :=
    Ideal.mul_mem_left _ _ three_mem_p3_OK
  have h2 : (2 : 𝓞 K) ^ 4 ∈ pbar2_OK ^ 4 := two_pow4_mem_pbar2_pow4
  have heq : (-5 : 𝓞 K) * 3 + (2 : 𝓞 K) ^ 4 = 1 := by norm_num
  rw [← heq]
  exact Ideal.add_mem _ (Ideal.mem_sup_left h3) (Ideal.mem_sup_right h2)

/-- p₇_OK ⊔ p₂_OK³ = ⊤.
    Witness: 1 = (−1)·7 + 2³.  Numerically: −7 + 8 = 1. -/
private theorem p7_sup_p2pow3_eq_top : p7_OK ⊔ p2_OK ^ 3 = ⊤ := by
  rw [Ideal.eq_top_iff_one]
  have h7 : (-1 : 𝓞 K) * 7 ∈ p7_OK :=
    Ideal.mul_mem_left _ _ seven_mem_p7_OK
  have h2 : (2 : 𝓞 K) ^ 3 ∈ p2_OK ^ 3 := two_pow3_mem_p2_pow3
  have heq : (-1 : 𝓞 K) * 7 + (2 : 𝓞 K) ^ 3 = 1 := by norm_num
  rw [← heq]
  exact Ideal.add_mem _ (Ideal.mem_sup_left h7) (Ideal.mem_sup_right h2)

/-- span{3+ω} ⊆ p₃_OK · p̄₂_OK⁴.
    Proof: p₃·p̄₂⁴ = p₃ ∩ p̄₂⁴ (coprime), and 3+ω ∈ p₃ ∩ p̄₂⁴. -/
theorem w3_span_le_p3_mul_pbar2pow4 :
    Ideal.span {(3 : 𝓞 K) + nω_OK} ≤ p3_OK * pbar2_OK ^ 4 := by
  rw [Ideal.mul_eq_inf_of_coprime p3_sup_pbar2pow4_eq_top,
      Ideal.span_singleton_le_iff_mem, Submodule.mem_inf]
  exact ⟨w3_mem_p3_OK, w3_mem_pbar2_pow4⟩

/-- span{4+ω} ⊆ p₇_OK · p₂_OK³.
    Proof: p₇·p₂³ = p₇ ∩ p₂³ (coprime), and 4+ω ∈ p₇ ∩ p₂³. -/
theorem w4_span_le_p7_mul_p2pow3 :
    Ideal.span {(4 : 𝓞 K) + nω_OK} ≤ p7_OK * p2_OK ^ 3 := by
  rw [Ideal.mul_eq_inf_of_coprime p7_sup_p2pow3_eq_top,
      Ideal.span_singleton_le_iff_mem, Submodule.mem_inf]
  exact ⟨w4_mem_p7_OK, w4_mem_p2_pow3⟩

-- ============================================================
-- §9. Named open surfaces
-- ============================================================

/-- **BSD_w3_ideal_equality_OPEN**: span{3+ω} = p₃·p̄₂⁴.
    The ⊆ direction is proved: w3_span_le_p3_mul_pbar2pow4.
    The ⊇ direction (norm equality 48 = 3·16) requires the ideal-norm API
    for each factor, absent from this file. -/
def BSD_w3_ideal_equality_OPEN : Prop :=
  Ideal.span {(3 : 𝓞 K) + nω_OK} = p3_OK * pbar2_OK ^ 4

/-- **BSD_w4_ideal_equality_OPEN**: span{4+ω} = p₇·p₂³.
    The ⊆ direction is proved: w4_span_le_p7_mul_p2pow3.
    The ⊇ direction (norm equality 56 = 7·8) requires the ideal-norm API. -/
def BSD_w4_ideal_equality_OPEN : Prop :=
  Ideal.span {(4 : 𝓞 K) + nω_OK} = p7_OK * p2_OK ^ 3

/-- **BSD_small_norm_in_zpowers_OPEN**: every nonzero ideal of absNorm ≤ 7
    has ClassGroup class in ⟨[p₂]⟩.

    Case analysis over norm ∈ {1, 2, 3, 4, 5, 6, 7}:
    • Norm 1: I = ⊤ → class = 1 ∈ ⟨[p₂]⟩.
    • Norm 2: I ∈ {p₂, p̄₂}; [p̄₂] = [p₂]⁻¹ from BSD_w3.
    • Norm 3: I ∈ {p₃, p̄₃}; [p₃] = [p₂]⁴ from BSD_w3.
    • Norm 4: products of norm-2 primes; in ⟨[p₂]⟩.
    • Norm 5: empty (5 is inert; prime above 5 has norm 25).
    • Norm 6: products of norm-2 and norm-3; in ⟨[p₂]⟩.
    • Norm 7: I ∈ {p₇, p̄₇}; [p₇] = [p₂]⁷ from BSD_w4.

    Gap: identification of ideals above 2, 3, 7 (UFD applied concretely). -/
def BSD_small_norm_in_zpowers_OPEN : Prop :=
  ∀ I : (Ideal (𝓞 K))⁰,
    Ideal.absNorm (I : Ideal (𝓞 K)) ≤ 7 →
    ClassGroup.mk0 I ∈ Subgroup.zpowers p2_class_gen

-- ============================================================
-- §10. Minkowski bound: norm ≤ 7 representative for each class
-- ============================================================

/-- The Minkowski bound for K = ℚ(√-143) is (2/π)·√143 ≈ 7.61 < 8.
    Hence every ideal class has a representative of absNorm ≤ 7. -/
private theorem minkowski_bound_le_seven (h_finrank : BSD_finrank_CLOSED)
    (h_discr : discr K = -143) (C : ClassGroup (𝓞 K)) :
    ∃ I : (Ideal (𝓞 K))⁰, ClassGroup.mk0 I = C ∧
        Ideal.absNorm (I : Ideal (𝓞 K)) ≤ 7 := by
  obtain ⟨I, hI_class, hI_norm⟩ := exists_ideal_in_class_of_norm_le C
  refine ⟨I, hI_class, ?_⟩
  have hNrC : NrComplexPlaces K = 1 := nrComplexPlaces_one_BSD h_finrank
  have h8 : 2 / Real.pi * Real.sqrt 143 < 8 := minkowski_lt_eight_BSD
  -- The Minkowski bound evaluates to (2/π)·√143 after substitution
  have hMink : (4 / Real.pi) ^ NrComplexPlaces K *
      ((finrank ℚ K).factorial / (finrank ℚ K) ^ (finrank ℚ K) *
        Real.sqrt (|(discr K : ℤ)| : ℝ)) =
      2 / Real.pi * Real.sqrt 143 := by
    rw [hNrC, h_finrank, h_discr]
    norm_num [Nat.factorial]
    ring
  -- Conclude (norm : ℝ) < 8
  have hlt8 : (Ideal.absNorm (I : Ideal (𝓞 K)) : ℝ) < 8 := by
    have := hI_norm.trans_eq hMink
    linarith
  -- nat < 8 implies nat ≤ 7
  have hlt8_nat : Ideal.absNorm (I : Ideal (𝓞 K)) < 8 := by exact_mod_cast hlt8
  omega

-- ============================================================
-- §11. Upper bound: classNumber K ≤ 10 (conditional)
-- ============================================================

/-- If BSD_small_norm_in_zpowers_OPEN holds, then [p₂] generates ClassGroup(𝓞K).
    Proof: Minkowski gives every class a norm-≤-7 representative; the hypothesis
    places every such representative in ⟨[p₂]⟩. -/
theorem BSD_classGroup_gen_by_p2_CLOSED_from_surface
    (h_small : BSD_small_norm_in_zpowers_OPEN)
    (h_finrank : BSD_finrank_CLOSED)
    (h_discr : discr K = -143) :
    BSD_classGroup_gen_by_p2_hyp := fun C => by
  obtain ⟨I, hI_class, h7⟩ := minkowski_bound_le_seven h_finrank h_discr C
  rw [← hI_class]
  exact h_small I h7

/-- **BSD_classGroupCard_le_10_CLOSED** (conditional on BSD_small_norm_in_zpowers_OPEN):
    classNumber K ≤ 10.

    Chain:
    1. BSD_small_norm_in_zpowers_OPEN + Minkowski → ClassGroup = ⟨[p₂]⟩
    2. BSD_orderOf_p2_eq_10 (proved unconditionally from BSD_p2_pow_10_principal)
       → orderOf [p₂] = 10
    3. ClassGroup cyclic, generated by element of order 10
       → |ClassGroup| = 10 → classNumber K = 10 ≤ 10. -/
theorem BSD_classGroupCard_le_10_CLOSED
    (h_small : BSD_small_norm_in_zpowers_OPEN)
    (h_finrank : BSD_finrank_CLOSED)
    (h_discr : discr K = -143) :
    NumberField.classNumber K ≤ 10 := by
  have hgen : BSD_classGroup_gen_by_p2_hyp :=
    BSD_classGroup_gen_by_p2_CLOSED_from_surface h_small h_finrank h_discr
  have htop : Subgroup.zpowers p2_class_gen = ⊤ := by
    ext x; exact ⟨fun _ => Subgroup.mem_top x, fun _ => hgen x⟩
  have hord : orderOf p2_class_gen = 10 :=
    BSD_orderOf_p2_eq_10 BSD_p2_pow_10_principal
  have hcard : Nat.card (ClassGroup (𝓞 K)) = 10 := by
    have hzp : Nat.card (Subgroup.zpowers p2_class_gen) = orderOf p2_class_gen :=
      Nat.card_zpowers
    rw [htop, Nat.card_eq_fintype_card] at hzp
    simp only [Subgroup.card_top] at hzp
    rw [← hzp, hord]
  rw [NumberField.classNumber, ← hcard, Nat.card_eq_fintype_card]

-- ============================================================
-- §12. Summary ledger
-- ============================================================

/-- Proved membership ledger (0 sorry, classical trio). -/
theorem BSD_upper_bound_ledger :
    ((3 : 𝓞 K) + nω_OK ∈ p3_OK) ∧
    ((3 : 𝓞 K) + nω_OK ∈ pbar2_OK ^ 4) ∧
    ((4 : 𝓞 K) + nω_OK ∈ p7_OK) ∧
    ((4 : 𝓞 K) + nω_OK ∈ p2_OK ^ 3) ∧
    (Ideal.span {(3 : 𝓞 K) + nω_OK} ≤ p3_OK * pbar2_OK ^ 4) ∧
    (Ideal.span {(4 : 𝓞 K) + nω_OK} ≤ p7_OK * p2_OK ^ 3) :=
  ⟨w3_mem_p3_OK, w3_mem_pbar2_pow4, w4_mem_p7_OK, w4_mem_p2_pow3,
   w3_span_le_p3_mul_pbar2pow4, w4_span_le_p7_mul_p2pow3⟩

end Towers.BSD
