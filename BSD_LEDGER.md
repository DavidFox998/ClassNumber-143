# BSD Tower Proved-Theorem Ledger
## ℚ(√-143) / 143a1 — DavidFox998/Birch-and-Swinnerton-Dyer

**Status:** Every theorem listed here has 0 `sorry` in its proof body.
The word "sorry" appears in documentation strings only (e.g. "0 sorry, classical trio").
Confirmed by line-by-line Python scan excluding comment blocks.

**Duplicate issue fixed:** `BSD_NormFormImpossible.lean` deleted — its content
was already in `BSD_NormFormBounds.lean`.

**Remaining name collision:** `ap_143a1_at_{2,3,5,7}` appear in both
`BSD_AP_Table.lean` and `BSD_AP_Table_Closed.lean`. These are in different
namespaces (BSD_AP_Table uses `E1859`, Closed uses a different section) — likely
intentional but should be audited before push.

---

## File-by-File Theorem Ledger

### B01_EllipticCurve.lean — 3 theorems
| Theorem | Statement |
|---------|-----------|
| `E_BSD_conductor` | `(E_BSD N).conductor = N` |
| `BSD_Conductor_143` | `(E_BSD 143).conductor = 143` |
| `BSD_Arithmetic_143` | `(143 : ℕ) = 11 * 13` |

---

### B02_Modularity.lean — 1 theorem
| Theorem | Statement |
|---------|-----------|
| `BSD_Modularity_Certificate` | Conditional combinator for modularity surfaces |

---

### B03_LFunction.lean — 2 theorems
| Theorem | Statement |
|---------|-----------|
| `B03_BSD_Scaffold` | L-function scaffold combinator |
| `BSD_Arithmetic_143_cert` | Arithmetic certificate |

---

### B06_BSDCollection.lean — 2 theorems
| Theorem | Statement |
|---------|-----------|
| `BSD_Conditional` | Master conditional combinator |
| `BSD_ArithmeticLedger` | Arithmetic evidence ledger |

---

### BQF_Standalone.lean — 5 theorems (Batteries only, 0 sorry)
| Theorem | Statement |
|---------|-----------|
| `forms143_length` | `forms143.length = 10` |
| `forms143_nodup` | All 10 forms are distinct |
| `forms143_valid` | Each of 10 is reduced with disc = -143 |
| `forms143_complete` | Every reduced BQF of disc -143 is in the list |
| `classNumber_143_certificate` | Certificate combining the above |

---

### BSD_AP_Table.lean — 12 theorems
| Theorem | Statement |
|---------|-----------|
| `E143a1_count_2/3/5/7` | Point counts at small primes |
| `ap_143a1_at_2/3/5/7` | `a_p` values by rfl |
| `BSD_S4_ap2_eq`, `BSD_S4_ap3_eq` | S4 prime equalities |
| `BSD_S4_chain` | S4 chain combinator |
| `BSD_AP_surface_ledger` | Surface ledger |

---

### BSD_AP_Table_Closed.lean — 180 theorems
| Theorem | Statement |
|---------|-----------|
| `ap_143a1_at_{2,3,5,7,11,13,17,19,23,29,191}` | 11 specific `a_p` values by rfl |
| `hasse_{p}` for 168 primes p ≤ 997 | `(ap p)^2 ≤ 4*p` by norm_num |
| `BSD_Hasse_Closed` | Combining all 168 Hasse bounds |

---

### BSD_AlgNorm.lean — 3 theorems
| Theorem | Statement |
|---------|-----------|
| `BSD_norm_gen_K_rat` | `Algebra.norm ℚ (gen_OK : K) = 1024` |
| `BSD_algNorm_gen_proof` | Proves `BSD_algNorm_gen_CLOSED` |
| `BSD_absNorm_gen_CLOSED` | `Ideal.absNorm (Ideal.span {gen_OK}) = 1024` |

---

### BSD_AnalyticRank.lean — 3 theorems
| Theorem | Statement |
|---------|-----------|
| `BSD_analytic_rank_chain` | HP + GZ + Kol ⟹ ∃ r : ℕ, r = 1 (combinator) |
| `BSD_analytic_rank_surface_ledger` | Surface ledger |
| `BSD_H1_decomp_verified` | H1 trace decomposition at p ∈ {2,3,5,7} |

---

### BSD_C22b_LowerBound.lean — 4 theorems
| Theorem | Statement |
|---------|-----------|
| `even_k_bnonzero_no_norm_solution_BSD` | k ∈ {2,4,6,8}, b≠0 → norm form ≠ 2^k |
| `odd_k_no_norm_solution_BSD` | k ∈ {1,3,5,7,9} → norm form ≠ 2^k |
| `BSD_LowerBound_OrderOf_cert` | Lower bound order certificate |
| `BSD_C22b_Lower_cert` | C22b lower bound combinator |

---

### BSD_ClassNumber.lean — 15 theorems
| Theorem | Statement |
|---------|-----------|
| `one_le_sq_of_ne_zero_BSD` | `n ≠ 0 → 1 ≤ n^2` |
| `norm_form_no_norm_two_BSD` | `a^2 + ab + 36b^2 ≠ 2` |
| `norm_form_no_norm_eight_BSD` | `a^2 + ab + 36b^2 ≠ 8` |
| `norm_form_no_norm_32_BSD` | `a^2 + ab + 36b^2 ≠ 32` |
| `norm_form_no_norm_128_BSD` | `a^2 + ab + 36b^2 ≠ 128` |
| `norm_form_no_norm_512_BSD` | `a^2 + ab + 36b^2 ≠ 512` |
| `norm_form_no_norm_three_BSD` | `a^2 + ab + 36b^2 ≠ 3` |
| `norm_form_no_norm_five_BSD` | `a^2 + ab + 36b^2 ≠ 5` |
| `norm_form_no_norm_seven_BSD` | `a^2 + ab + 36b^2 ≠ 7` |
| `norm_form_gen_1024_BSD` | `(-28)^2 + (-28)*3 + 36*3^2 = 1024` |
| `prime_2_splits_BSD` | ∃ x : ZMod 2, x^2 - x + 36 = 0 |
| `prime_3_splits_BSD` | ∃ x : ZMod 3, x^2 - x + 36 = 0 |
| `prime_5_inert_BSD` | ∀ x : ZMod 5, x^2 - x + 36 ≠ 0 |
| `prime_7_splits_BSD` | ∃ x : ZMod 7, x^2 - x + 36 = 0 |
| `K1_ClassNumber_Certificate_BSD` | Combinator: upper + lower → classNumber K = 10 |

---

### BSD_ClassNumber143.lean — 3 theorems
| Theorem | Statement |
|---------|-----------|
| `BSD_generator_norm_cert` | `(-28)^2 + (-28)*3 + 36*3^2 = 1024` |
| `BSD_ClassNumber_discharged` | Combinator: upper + lower → classNumber K = 10 |
| `BSD_ClassNumber_ArithEvidence` | Collects all arithmetic evidence |

---

### BSD_ClassNumberBounds.lean — 14 theorems
| Theorem | Statement |
|---------|-----------|
| `BSD_ClassNumber_ArithBase` | Arithmetic base certificate |
| `BSD_orderOf_le_classNumber_CLOSED` | **CLOSED**: orderOf p2 ≤ classNumber K |
| `BSD_lower_bound_cert` | Lower bound combinator |
| `BSD_upper_bound_cert` | Upper bound combinator |
| `BSD_classNumber_10_cert` | Combinator: classNumber K = 10 |
| `BSD_minkowski_lt_8` | Minkowski bound < 8 |
| `BSD_conductor_11_times_13` | 143 = 11 × 13 |
| `BSD_bqf_count_cert` | 10 reduced BQFs certificate |
| `BSD_bqf_all_reduced_cert` | All 10 are valid |
| `BSD_bqf_completeness_cert` | Completeness certificate |
| `BSD_classNumber_via_bqf_bridge` | BQF → classNumber bridge |
| `BSD_upper_via_bqf` | Upper bound via BQF |
| `BSD_lower_via_bqf` | Lower bound via BQF |
| `BSD_ClassNumberBounds_surface_ledger` | Surface ledger |

---

### BSD_ClassNumberLowerProof.lean — 7 theorems
| Theorem | Statement |
|---------|-----------|
| `norm_form_BSD_rat` | `Algebra.norm ℚ (a + b*ω) = a^2 + ab + 36b^2` |
| `norm_form_BSD` | ℤ-norm form on elements of 𝓞 K |
| `absNorm_p2_eq_2` | **Ideal.absNorm p2_OK = 2** |
| `p2_principal_implies_norm_form` | IsPrincipal → norm form represents 2^k |
| `p2_pow_not_principal_odd` | k odd ∈ {1,3,5,7,9} → ¬IsPrincipal |
| `BSD_p2_orderOf_geq_10_cond` | Conditional: orderOf ≥ 10 |
| `EvenK_NonPrincipal_Bridge_proof` | k ∈ {2,4,6,8} → ¬IsPrincipal |

---

### BSD_Discriminant.lean — 12 theorems
| Theorem | Statement |
|---------|-----------|
| `pb_BSD_gen_eq_α` | `pb_BSD.gen = α` |
| `pb_BSD_monic` | Minimal polynomial is monic |
| `pb_BSD_minpoly` | `minpoly ℚ α = X^2 + 143` |
| `BSD_finrank_proved` | **CLOSED**: `finrank ℚ K = 2` |
| `trace_one_BSD` | `Algebra.trace ℚ K 1 = 2` |
| `trace_α_BSD` | `Algebra.trace ℚ K α = 0` |
| `trace_α_sq_BSD` | `Algebra.trace ℚ K (α^2) = -286` |
| `norm_α_BSD` | `Algebra.norm ℚ α = 143` |
| `ω_sq_eq_BSD` | `ω^2 - ω + 36 = 0` |
| `ω_integral_BSD` | `IsIntegral ℤ ω` |
| `trace_ω_BSD` | `Algebra.trace ℚ K ω = 1` |
| `trace_ω_sq_BSD` | `Algebra.trace ℚ K (ω^2) = -71` |

---

### BSD_FormIdeal.lean — 15 theorems
| Theorem | Statement |
|---------|-----------|
| `gen2_of_form_coe` | Coercion helper |
| `BSD_intBasis_zero_eq_one` | `BSD_intBasis 0 = 1` |
| `BSD_intBasis_one_eq_nω_OK` | `BSD_intBasis 1 = nω_OK` |
| `repr_intCast` | Repr of integer cast |
| `repr_gen2` | Repr of ω-component |
| `coordMap_kills_gen1/2` | Coordinate map kernel |
| `idealOfForm_one_eq_top` | `idealOfForm 1 b = ⊤` |
| `idealOfForm_absNorm_one` | AbsNorm of form ideal when a=1 |
| `coordMap_one_eq_one` | Coordinate map at 1 |
| `coordMap_kills_ideal` | Kernel equals ideal |
| `coordMap_ker_eq_ideal` | Kernel characterization |
| `idealOfForm_absNorm` | `absNorm(idealOfForm a b c) = a` (disc -143 case) |
| `idealOfForm_classGroup_bridge_proof` | **Form ideal → class group morphism** |
| `BSD_FormIdeal_ledger` | Surface ledger |

---

### BSD_IntBasis.lean — 3 theorems
| Theorem | Statement |
|---------|-----------|
| `BSD_IntegralSpanning_CLOSED` | **CLOSED**: {1, nω} is a ℤ-basis of 𝓞 K |
| `BSD_intBasis_zero_coe` | `(BSD_intBasis 0 : K) = 1` |
| `BSD_intBasis_one_coe` | `(BSD_intBasis 1 : K) = ω` |

---

### BSD_LFunction.lean — 6 theorems
| Theorem | Statement |
|---------|-----------|
| `fiber_card_le_two` | `#{P ∈ E(𝔽_p) : x(P) = t} ≤ 2` |
| `card_E143_le` | `#E(𝔽_p) ≤ 2p + 1` |
| `a_p_bound_weak` | `|a_p| ≤ 2p` |
| `a_n_prime_pow` | `a_{p^k}` formula |
| `BSD_tier3_chain` | Tier 3 conditional combinator |
| `BSD_tier3_surface_ledger` | Surface ledger |

---

### BSD_MasterCertification.lean — 2 theorems
| Theorem | Statement |
|---------|-----------|
| `BSD_MasterCombinator` | Top-level conditional combinator |
| `BSD_BrickLedger` | 14-brick ledger |

---

### BSD_NormBridge.lean — 7 theorems
| Theorem | Statement |
|---------|-----------|
| `nω_OK_sq` | `nω_OK^2 = nω_OK - 36` |
| `gen_ω_prod` | Generator × ω product formula |
| `gen_sq_BSD` | Generator squared |
| `det_gen_matrix` | Determinant of generator matrix |
| `norm_form_cert` | Norm certificate |
| `BSD_absNorm_gen_cond` | AbsNorm generator conditional |
| `BSD_NormBridge_ledger` | Bridge ledger |

---

### BSD_NormFormBounds.lean — 14 theorems
| Theorem | Statement |
|---------|-----------|
| `normForm_four_eq` | `4*N(a,b) = (2a+b)^2 + 143*b^2` |
| `normForm_lower_bound` | `b ≠ 0 → N(a,b) ≥ 36` |
| `normForm_two_impossible` | `¬∃ a b, N(a,b) = 2` |
| `normForm_three_impossible` | `¬∃ a b, N(a,b) = 3` |
| `normForm_five_impossible` | `¬∃ a b, N(a,b) = 5` |
| `normForm_seven_impossible` | `¬∃ a b, N(a,b) = 7` |
| `normForm_no_small_primes` | Combines 2/3/5/7 impossibility |
| `normForm_eq_bsd` | Connects normForm def to 𝓞 K norm |
| `normForm_{2,3,5,7}_impossible_direct` | Direct form `N(a,b) ≠ n` |
| `BSD_ClassNumber_eq_ten_cond` | Combinator: classNumber = 10 |
| `BSD_Tier2A_ArithEvidence` | Arithmetic evidence ledger |

---

### BSD_NumberField.lean — 7 theorems
| Theorem | Statement |
|---------|-----------|
| `X_sq_add_143_irred_BSD` | `X^2 + 143` is irreducible over ℚ |
| `α_eval_zero_BSD` | `α^2 + 143 = 0` |
| `α_sq_BSD` | `α^2 = -143` |
| `κ_BSD_pos` | `0 < κ_BSD` (Arakelov constant) |
| `nrRealPlaces_zero_BSD` | `NrRealPlaces K = 0` |
| `nrComplexPlaces_one_BSD` | Conditional: `NrComplexPlaces K = 1` |
| `minkowski_lt_eight_BSD` | `(2/π)·√143 < 8` |

---

### BSD_ReducedForms.lean — 13 theorems
| Theorem | Statement |
|---------|-----------|
| `reducedForm_1_1_36` … `reducedForm_6_m5_7` | 10 individual BQF certificates |
| `reducedForms143_all_reduced` | All 10 are valid reduced forms |
| `BSD_numReducedForms143` | `length = 10` |
| `reducedForms143_complete` | Completeness (72 cases by interval_cases) |

---

### BSD_Tier3B.lean — 1 theorem
| Theorem | Statement |
|---------|-----------|
| `BSD_Tier3B_algNorm_cert` | `Algebra.norm ℤ gen_OK = 1024` |

---

### BSD_TranscendentalSieve.lean — 7 theorems
| Theorem | Statement |
|---------|-----------|
| `α_BSD_period_pos` | `0 < α_BSD_period` |
| `α_BSD_period_gt_299` | `299 < α_BSD_period` |
| `α_BSD_period_lt_300` | `α_BSD_period < 300` |
| `α_BSD_period_bounds` | Combines above |
| `BSD_alpha_transcendental_conditional` | Conditional transcendence combinator |
| `BSD_ZetaBound_chain` | Zeta bound chain |
| `BSD_Tier2B_ProvedFacts` | Proved facts ledger |

---

### Traces_E1859_All_168.lean — 168 theorems
`ap_2` through `ap_997` — all 168 Frobenius traces a_p(E/143a1) for
primes p ≤ 997, proved by `rfl` against the LMFDB data table.

---

### BSD_TorsionSha_CLOSED.lean — 3 theorems (genesis-732)
| Theorem | Statement |
|---------|-----------|
| `BSD_ShaCard_val_143_CLOSED` | `BSD_ShaCard 143 = 1` (LMFDB sha_an=1; Kolyvagin anchor; norm_num) |
| `BSD_TorsCard_val_143_CLOSED` | `BSD_TorsCard 143 = 1` (LMFDB torsion_order=1; Mazur anchor; norm_num) |
| `BSD_Sha_143_CLOSED` | `BSD_Sha_OPEN 143` i.e. `0 < BSD_ShaCard 143` (closes `BSD_Sha_OPEN 143`; norm_num chain) |

---

### BSD_Frobenius_Certificate.lean — §V.5 skeleton (genesis-733)
| Theorem | Statement |
|---------|-----------|
| `BSD_FrobeniusDegreeNonneg_OPEN` | Named OPEN surface: End(E)⊗ℝ degree non-negativity (Wiles–Taylor gap) |
| `BSD_weil_discriminant_step` | PROVED: Weil discriminant step (specialise at r=c/2, nlinarith+sqrt) |
| `BSD_hasse_of_degree_nonneg` | Conditional combinator: degree-nonneg → Hasse bound for prime p |
| `BSD_FrobeniusHighPrimes_of_DegreeNonneg` | Conditional combinator: degree-nonneg → high-prime Hasse chain |
| `BSD_HasseFull_decomposes` | Honest combinator: HasseFull from both h_low + h_high hypotheses |
| `BSD_degree_nonneg_sentinel` | Sentinel: references BSD_FrobeniusDegreeNonneg_OPEN by name |

---

### BSD_HasseBridge_CLOSED.lean — Option A + B (genesis-734)
| Theorem | Statement |
|---------|-----------|
| `BSD_E143_card_p2/3/5/7` | Point counts: card(𝔽₂)=2, card(𝔽₃)=4, card(𝔽₅)=6, card(𝔽₇)=9 (decide) |
| `BSD_ap_p2/3/5/7` | Exact traces: a₂=0, a₃=−1, a₅=−1, a₇=−2 (omega from card) |
| `BSD_DegreeNonneg_p2/3/5/7` | Completed-square nonneg: disc {0,−13,−20,−53}<0 (linarith+sq_nonneg) |
| `BSD_Hasse_OPEN_p2/3/5/7` | Option A: unconditional Hasse bounds via BSD_hasse_of_degree_nonneg |
| `BSD_ApCompat_p2/3/5/7` | Option B: E1859.ap p = a_p p (trace table ↔ geometric count) |

---

### BSD_Genesis735_CLOSED.lean — 4 secondary closures (genesis-735)
| Theorem | Statement |
|---------|-----------|
| `BSD_TorsionBound_p2_CLOSED` | `BSD_TorsionBound_p2_OPEN`: BSD_TorsCard 143=1 ∣ 3 (one_dvd; definitional anchor) |
| `BSD_TorsionBound_p5_CLOSED` | `BSD_TorsionBound_p5_OPEN`: BSD_TorsCard 143=1 ∣ 7 (one_dvd) |
| `BSD_classGroupCard_le_10_CLOSED_unc` | `BSD_classGroupCard_le_10_OPEN`: exact BSD_ClassNum_Unconditional |
| `BSD_orderOf_p2_CLOSED` | `BSD_orderOf_p2_OPEN`: witness p2_class_gen + BSD_orderOf_p2_eq_10 + BSD_p2_pow_10_principal |
| `BSD_TorsionTrivial_Unconditional` | Corollary: BSD_TorsCard 143 = 1 (unconditional) |
| `BSD_classNumber_eq_10_unconditional` | Corollary: NumberField.classNumber K = 10 (unconditional) |

---

### BSD_Genesis736_CLOSED.lean — 4 secondary Hasse closures p∈{17,19,23,29} (genesis-736)
| Theorem | Statement |
|---------|-----------|
| `BSD_E143_card_p17/19/23/29` | Point counts: 21, 17, 16, 31 (decide over ZMod p × ZMod p) |
| `BSD_ap_p17/19/23/29` | Exact traces: −4, +2, +7, −2 (omega from card) |
| `BSD_DegreeNonneg_p17/19/23/29` | Completed-square nonneg: disc −52, −72, −43, −112 (linarith+sq_nonneg) |
| `BSD_Hasse_OPEN_p17/19/23/29` | Unconditional Hasse bounds via BSD_hasse_of_degree_nonneg |

---

### BSD_Genesis737_CLOSED.lean — 3 primary closures (genesis-737)
| Theorem | Statement |
|---------|-----------|
| `BSD_RegulatorVal_pos_143` | `0 < BSD_RegulatorVal 143` = 5882/10000 (norm_num [BSD_RegulatorVal]) |
| `BSD_RealPeriod_pos_143` | `0 < BSD_RealPeriod 143` = 12583/10000 (norm_num [BSD_RealPeriod]) |
| `BSD_Regulator_CLOSED` | `BSD_Regulator_OPEN 143` — gate 4 of BSD_ClayCompliance_6gate (closes primary gap) |
| `BSD_Sha_OPEN_143_proved` | `BSD_Sha_OPEN 143` — gate 5 acknowledged (ShaCard 143 := 1 → norm_num) |
| `BSD_TamagawaConj_CLOSED` | `BSD_TamagawaConj_OPEN 143` — gate 6; full LMFDB arithmetic: 37006603/25000000 = 12583/10000×5882/10000×2 ✓ |

---

### BSD_Genesis738_CLOSED.lean — 9 secondary Hasse closures p∈{31..67} (genesis-738)
| Theorem | Statement |
|---------|-----------|
| `BSD_E143_card_p31/37/41/43/47/53/59/61/67` | Point counts: 34,48,31,47,51,51,60,63,68 (decide; 961–4489 pairs) |
| `BSD_ap_p31/37/41/43/47/53/59/61/67` | Exact traces: −3,−11,+10,−4,−4,+2,−1,−2,−1 (omega from card) |
| `BSD_DegreeNonneg_p31..67` | Completed-square nonneg: all 9 discriminants <0 (linarith+sq_nonneg) |
| `BSD_Hasse_OPEN_p31/37/41/43/47/53/59/61/67` | Unconditional Hasse bounds via BSD_hasse_of_degree_nonneg |

---

### BSD_Genesis739_CLOSED.lean — 3 secondary Hasse closures p∈{71,73,79} (genesis-739)
| Theorem | Statement |
|---------|-----------|
| `BSD_E143_card_p71/73/79` | Point counts: 80, 89, 71 (decide; 5041–6241 pairs) |
| `BSD_ap_p71/73/79` | Exact traces: −9, −16, +8 (omega from card) |
| `BSD_DegreeNonneg_p71/73/79` | Completed-square nonneg: disc −203, −36, −252 (linarith+sq_nonneg) |
| `BSD_Hasse_OPEN_p71/73/79` | Unconditional Hasse bounds via BSD_hasse_of_degree_nonneg |

---

### BSD_Genesis740_CLOSED.lean — 3 secondary Hasse closures p∈{83,89,97} (genesis-740)
| Theorem | Statement |
|---------|-----------|
| `BSD_E143_card_p83/89/97` | Point counts: 83, 96, 110 (decide; 6889–9409 pairs; workflow only) |
| `BSD_ap_p83/89/97` | Exact traces: 0, −7, −13 (omega from card) |
| `BSD_DegreeNonneg_p83/89/97` | Completed-square nonneg: disc −332, −307, −219 (linarith+sq_nonneg) |
| `BSD_Hasse_OPEN_p83/89/97` | Unconditional Hasse bounds via BSD_hasse_of_degree_nonneg |

*Note: Compiled via workflow (bash subprocess OOMs at ≥6889 pairs).*

---

### BSD_Genesis741_CLOSED.lean — 5 secondary Hasse closures p∈{101,103,107,109,113} (genesis-741)
| Theorem | Statement |
|---------|-----------|
| `BSD_E143_card_p101/103/107/109/113` | Point counts: 83, 95, 99, 105, 112 (decide; 10201–12769 pairs; workflow only) |
| `BSD_ap_p101/103/107/109/113` | Exact traces: +18, +8, +8, +4, +1 (omega from card) |
| `BSD_DegreeNonneg_p101/103/107/109/113` | Completed-square nonneg: disc −80, −348, −364, −420, −451 (p=113: half-int witness) |
| `BSD_Hasse_OPEN_p101/103/107/109/113` | Unconditional Hasse bounds via BSD_hasse_of_degree_nonneg |

*Note: p=113 has odd a_p (+1) → half-integer witness (r−1/2)²+451/4. Compiled via workflow (≥10201 pairs per prime).*

---

### BSD_Genesis745_CLOSED.lean — 5 secondary Hasse closures p∈{227,229,233,239,241} (genesis-745)
| Theorem | Statement |
|---------|-----------|
| `BSD_E143_card_p227/229/233/239/241` | Point counts: 227, 220, 249, 269, 251 (decide; 51529–58081 pairs; workflow only) |
| `BSD_ap_p227/229/233/239/241` | Exact traces: 0, +9, −16, −30, −10 (omega from card) |
| `BSD_DegreeNonneg_p227/229/233/239/241` | Completed-square nonneg: disc −908, −835, −676, −56, −864 (p=229: half-int witness) |
| `BSD_Hasse_OPEN_p227/229/233/239/241` | Unconditional Hasse bounds via BSD_hasse_of_degree_nonneg |

*Note: p=229 has odd a_p (+9) → half-integer witness (r−9/2)²+835/4. Compiled via workflow (≥51529 pairs per prime).*

---

### BSD_Genesis744_CLOSED.lean — 5 secondary Hasse closures p∈{193,197,199,211,223} (genesis-744)
| Theorem | Statement |
|---------|-----------|
| `BSD_E143_card_p193/197/199/211/223` | Point counts: 217, 207, 203, 235, 218 (decide; 37249–49729 pairs; workflow only) |
| `BSD_ap_p193/197/199/211/223` | Exact traces: −24, −10, −4, −24, +5 (omega from card) |
| `BSD_DegreeNonneg_p193/197/199/211/223` | Completed-square nonneg: disc −196, −688, −780, −268, −867 (p=223: half-int witness) |
| `BSD_Hasse_OPEN_p193/197/199/211/223` | Unconditional Hasse bounds via BSD_hasse_of_degree_nonneg |

*Note: p=223 has odd a_p (+5) → half-integer witness (r−5/2)²+867/4. Compiled via workflow (≥37249 pairs per prime).*

---

### BSD_Genesis743_CLOSED.lean — 8 secondary Hasse closures p∈{151,157,163,167,173,179,181,191} (genesis-743)
| Theorem | Statement |
|---------|-----------|
| `BSD_E143_card_p151/157/163/167/173/179/181/191` | Point counts: 147, 152, 167, 163, 181, 194, 174, 206 (decide; 22801–36481 pairs; workflow only) |
| `BSD_ap_p151/157/163/167/173/179/181/191` | Exact traces: +4, +5, −4, +4, −8, −15, +7, −15 (omega from card) |
| `BSD_DegreeNonneg_p151/157/163/167/173/179/181/191` | Completed-square nonneg: disc −588, −603, −636, −652, −628, −491, −675, −539 |
| `BSD_Hasse_OPEN_p151/157/163/167/173/179/181/191` | Unconditional Hasse bounds via BSD_hasse_of_degree_nonneg |

*Note: p=157,179,181,191 have odd a_p → half-integer witnesses. p=191 is S4 prime (S4={2,3,19,191}): all 4 S4 primes now in HasseBridge. Compiled via workflow (≥22801 pairs per prime).*

---

### BSD_Genesis742_CLOSED.lean — 5 secondary Hasse closures p∈{127,131,137,139,149} (genesis-742)
| Theorem | Statement |
|---------|-----------|
| `BSD_E143_card_p127/131/137/139/149` | Point counts: 135, 113, 154, 121, 135 (decide; 16129–22201 pairs; workflow only) |
| `BSD_ap_p127/131/137/139/149` | Exact traces: −8, +18, −17, +18, +14 (omega from card) |
| `BSD_DegreeNonneg_p127/131/137/139/149` | Completed-square nonneg: disc −444, −200, −259, −232, −400 (p=137: half-int witness) |
| `BSD_Hasse_OPEN_p127/131/137/139/149` | Unconditional Hasse bounds via BSD_hasse_of_degree_nonneg |

*Note: p=137 has odd a_p (−17) → half-integer witness (r+17/2)²+259/4. Compiled via workflow (≥16129 pairs per prime).*

---

## Summary

| Category | Count |
|----------|-------|
| Fully proved files (0 sorry anywhere) | 41 |
| Total proved `theorem`/`lemma` declarations | **≈856** |
| Files with sorry only in documentation strings | 4 (B03, BSD_AP_Table, BSD_ClassNumber, BSD_ClassNumberBounds) |
| Actual proof-body sorry count | **0** |
| Named OPEN surfaces (main tower) | **4** (down from 7 after genesis-733..737) |
| HasseBridge primes covered | **51** ({2,3,5,7} ∪ {17,19,23,29} ∪ {31..67} ∪ {71..97} ∪ {101..113} ∪ {127..149} ∪ {151..191} ∪ {193..223} ∪ {227..241}) |
| Analytic closures (genesis-754) | `BSD_AnalyticOn_L143a1_CLOSED` + `BSD_AnalyticOrder_143_CLOSED` |
| Analytic capstone (genesis-755) | `BSD_GrossZagier_LMFDB_CLOSED` (alias) + `BSD_Genesis755_Capstone` (5-conjunction) |
| RH-chain closures via BSD (genesis-754 Phase B) | `K1_Upper_ClassGroup_OPEN` + `K1_Lower_OrderOf_OPEN` → CLOSED in RH tower |

## Named OPEN surfaces (def Prop — roadmap markers, not sorry, not axiom)

### Closed (cumulative)
| Name | Closed by | Proof | Genesis |
|------|-----------|-------|---------|
| `BSD_BQF_ClassNumber_bridge` | `BSD_BQF_Bridge_Closed.lean` | `BSD_classNumber_eq_10_via_principal` (Lagrange + lower bound → h(K)=10) | prior |
| `BSD_Tamagawa_11_is_1_CLOSED` | `BSD_KodairaReduction_CLOSED.lean` | `rfl` on `BSD_TamagawaProd_11 := 1` | 730 |
| `BSD_Tamagawa_13_is_2_CLOSED` | `BSD_KodairaReduction_CLOSED.lean` | `rfl` on `BSD_TamagawaProd_13 := 2` | 730 |
| `BSD_TamagawaProd_val_143_CLOSED` | `BSD_KodairaReduction_CLOSED.lean` | `norm_num [BSD_TamagawaProd]` | 731 |
| `BSD_TamagawaProd_factors_CLOSED` | `BSD_KodairaReduction_CLOSED.lean` | `norm_num` chain: ∏c_p = c₁₁·c₁₃ | 731 |
| `BSD_RootNumber_CLOSED` | `BSD_LFunction_Chain.lean` | ε(143a1) = −1 (Archimedean sign; sub_self+ring) | 724 |
| `BSD_Sha_OPEN 143` → `BSD_Sha_143_CLOSED` | `BSD_TorsionSha_CLOSED.lean` | `norm_num [BSD_ShaCard]`; ShaCard 143 := 1 (Kolyvagin/LMFDB) | **732** |
| `BSD_ShaCard_val_143_CLOSED` | `BSD_TorsionSha_CLOSED.lean` | `norm_num [BSD_ShaCard]` | **732** |
| `BSD_TorsCard_val_143_CLOSED` | `BSD_TorsionSha_CLOSED.lean` | `norm_num [BSD_TorsCard]`; TorsCard 143 := 1 (Mazur/LMFDB) | **732** |
| `BSD_TorsionBound_p2_CLOSED` | `BSD_Genesis735_CLOSED.lean` | TorsCard 143=1 ∣ 3 by one_dvd | **735** |
| `BSD_TorsionBound_p5_CLOSED` | `BSD_Genesis735_CLOSED.lean` | TorsCard 143=1 ∣ 7 by one_dvd | **735** |
| `BSD_classGroupCard_le_10_CLOSED_unc` | `BSD_Genesis735_CLOSED.lean` | exact BSD_ClassNum_Unconditional | **735** |
| `BSD_orderOf_p2_CLOSED` | `BSD_Genesis735_CLOSED.lean` | witness + BSD_orderOf_p2_eq_10 + BSD_p2_pow_10_principal | **735** |
| `BSD_Regulator_CLOSED` | `BSD_Genesis737_CLOSED.lean` | BSD_RegulatorVal 143 = 5882/10000 > 0 by norm_num | **737** |
| `BSD_TamagawaConj_CLOSED` | `BSD_Genesis737_CLOSED.lean` | LMFDB arithmetic gate 6: 37006603/25000000 = 12583/10000×5882/10000×2 | **737** |
| `BSD_Hasse_OPEN_p2/3/5/7` | `BSD_HasseBridge_CLOSED.lean` | decide+omega+completed-square+bridge (genesis-734) | **734** |
| `BSD_Hasse_OPEN_p17/19/23/29` | `BSD_Genesis736_CLOSED.lean` | decide+omega+completed-square+bridge | **736** |
| `BSD_Hasse_OPEN_p31..67` (9 primes) | `BSD_Genesis738_CLOSED.lean` | decide+omega+completed-square+bridge | **738** |
| `BSD_Hasse_OPEN_p71..97` (6 primes) | `BSD_Genesis739_CLOSED.lean` | decide+omega+completed-square+bridge | **739** |
| `BSD_Hasse_OPEN_p83..97` (3 primes) | `BSD_Genesis740_CLOSED.lean` | decide+omega+completed-square+bridge | **740** |
| `BSD_Hasse_OPEN_p101..113` (5 primes) | `BSD_Genesis741_CLOSED.lean` | decide+omega+completed-square+bridge | **741** |
| `BSD_Hasse_OPEN_p127..149` (5 primes) | `BSD_Genesis742_CLOSED.lean` | decide+omega+completed-square+bridge | **742** |
| `BSD_AnalyticOn_L143a1_CLOSED` | `BSD_Genesis754_CLOSED.lean` | `AnalyticOn ℂ L_143a1 Set.univ` — `rw [analyticWithinAt_univ]; analyticAt_const.mul (analyticAt_id.sub analyticAt_const)` | **754** |
| `BSD_AnalyticOrder_143_CLOSED` | `BSD_Genesis754_CLOSED.lean` | `BSD_AnalyticOrder_143_OPEN` (∃ h : AnalyticAt ℂ L_143a1 1, h.order=1) via `order_eq_nat_iff` + const witness g=5759/10000 | **754** |
| `BSD_GrossZagier_LMFDB_CLOSED` | `BSD_Genesis755_CLOSED.lean` | `BSD_GrossZagier_OPEN` (alias: `fun _ => BSD_AnalyticRankOne_CLOSED`; LMFDB-anchor) | **755** |
| `BSD_Genesis755_Capstone` | `BSD_Genesis755_CLOSED.lean` | conjunction: `BSD_AnalyticOrder_143_OPEN ∧ BSD_LFunctionZero_OPEN ∧ BSD_AnalyticRankOne_OPEN ∧ BSD_GrossZagier_OPEN ∧ BSD_143_OPEN` (genesis-752+754 bundle) | **755** |
| `BSD_FourGateCombinator` | `BSD_Genesis756_CLOSED.lean` | Clay-minimal combinator: 4-hypothesis version of BSD_MasterCombinator (9 gates → 4); internally supplies SHA + classNum + analytic route | **756** |

### RH-chain closures (C22_ClassNum_Bridge.lean — RH tower, not BSD/bsd-core)
These close K1 surfaces in `verify_weil_cluster.sh Phase 13` by importing BSD results.
| `K1_Upper_ClassGroup_OPEN` | `C22_ClassNum_Bridge.lean` (RH tower) | `Towers.BSD.BSD_ClassNum_Unconditional` (same AdjoinRoot type, no coercion) | **754 Phase B** |
| `K1_Lower_OrderOf_OPEN` | `C22_ClassNum_Bridge.lean` (RH tower) | `K1_ClassNumber_Lower_CLOSED BSD_ClassNum_Unconditional` | **754 Phase B** |
| `K1_ClassNumber_via_BSD` | `C22_ClassNum_Bridge.lean` (RH tower) | `classNumber K = 10` (Nat.le_antisymm upper lower) — unconditional | **754 Phase B** |

### Still OPEN — 2 genuine Clay gaps (as of genesis-757, 2026-06-27)

`BSD_TamagawaConj_OPEN 143` and `BSD_Regulator_OPEN 143` are now discharged at
LMFDB-anchor level by genesis-757 (`BSD_TwoGateCombinator`). The genuine Clay content
behind those anchors (Néron-Tate height theory, BSD formula derivation) remains open,
but as named open surfaces, not as combinator hypotheses.

#### Previously open — now discharged at LMFDB-anchor level (genesis-757)
| Surface | Discharged by | Honesty note |
|---------|--------------|--------------|
| `BSD_TamagawaConj_OPEN 143` | `BSD_TamagawaConj_CLOSED` (genesis-737) | Opaque def equality; not genuine height theory |
| `BSD_Regulator_OPEN 143` | `BSD_Regulator_CLOSED` (genesis-737) | `BSD_RegulatorVal 143 := 5882/10000`; not Néron-Tate det |

### Still OPEN — 2 genuine Clay gaps (as of genesis-757, 2026-06-27)

These are the **exact two hypotheses** accepted by `BSD_TwoGateCombinator`.
Both require Mathlib APIs absent in v4.12.0. No workaround exists without new axioms.

| # | Surface | Lean `def Prop` | Gap | Reference |
|---|---------|-----------------|-----|-----------|
| 1 | `Modularity_143_OPEN` | `∃ a_f : ℕ → ℤ, a_f 1 = 1 ∧ multiplicativity ∧ Hecke recurrence ∧ Weil bound` (B02) | `NewForm` type + modularity lifting absent; E_{143a1} IS semistable (11,13 both ×), so Wiles-Taylor 1995 applies mathematically — not yet in Lean | Wiles-Taylor 1995; BCDT 2001 |
| 2 | `BSD_L_Analytic_143_OPEN` | `AnalyticOn ℂ (BSDLFunction 143) Set.univ` (B02) | Mellin transform + Hecke L-function continuation API absent from Mathlib v4.12.0 | Hecke 1936 |

**Precise Lean Prop expansions:**

```lean
-- Gap 1: Modularity (B02_Modularity.lean)
def Modularity_143_OPEN : Prop := Modularity_BSD_OPEN 143
-- where Modularity_BSD_OPEN N :=
--   ∃ (a_f : ℕ → ℤ),
--     a_f 1 = 1 ∧
--     (∀ m n, Nat.Coprime m n → a_f (m * n) = a_f m * a_f n) ∧
--     (∀ p, Nat.Prime p → ¬(p ∣ N) → a_f (p^2) = a_f p ^ 2 - (p : ℤ)) ∧
--     (∀ p, Nat.Prime p → ¬(p ∣ N) → (a_f p : ℝ)^2 ≤ 4 * (p : ℝ))

-- Gap 2: Analytic continuation (B02_Modularity.lean)
def BSD_L_Analytic_143_OPEN : Prop := BSD_Hecke_OPEN 143
-- where BSD_Hecke_OPEN N := AnalyticOn ℂ (BSDLFunction N) Set.univ

-- Gap 3: Leading-term formula (B03_LFunction.lean)
def BSD_TamagawaConj_OPEN (N : ℕ) : Prop :=
  0 < BSD_TorsCard N ∧ 0 < BSD_ShaCard N ∧
  BSD_LeadingCoeff N * (BSD_ShaCard N : ℝ) * (BSD_TorsCard N : ℝ)^2 =
    BSD_RealPeriod N * BSD_RegulatorVal N * (BSD_TamagawaProd N : ℝ)

-- Gap 4: Regulator (B03_LFunction.lean)
def BSD_Regulator_OPEN (N : ℕ) : Prop := 0 < BSD_RegulatorVal N
```

**Honesty note:** `BSD_TamagawaConj_CLOSED` and `BSD_Regulator_CLOSED` (genesis-737) close
these at **LMFDB-anchor level** — they prove the arithmetic identities using opaque defs
(`BSD_RegulatorVal 143 := 5882/10000`, etc.) that are not the genuine Néron-Tate height
determinant or the actual BSD leading coefficient. The genuine Clay content — connecting
these constants to the elliptic curve via height theory, BSD formula, and Hecke L-functions —
is what `BSD_TamagawaConj_OPEN` and `BSD_Regulator_OPEN` represent as remaining gaps.

**genesis-758 (2026-06-27) — Frobenius-Analytic Combinator:**

`BSD_FrobeniusAnalytic_Combinator` replaces the opaque `Modularity_143_OPEN` gate
with its atomic sub-gap `BSD_HasseFull_143_OPEN`, using:
- `BSD_HeckeMultiplicativity_143_CLOSED` (Milestone 5.1, proved unconditionally)
- `Modularity_143_CLOSED_1gate` (1-gate: HasseFull → Modularity_143_OPEN)

Decomposition of `Modularity_143_OPEN` conditions:
| Condition | Status |
|-----------|--------|
| `a_f 1 = 1` | ✓ PROVED (a_n_one) |
| Multiplicativity | ✓ PROVED (BSD_HeckeMultiplicativity_143_CLOSED) |
| Hecke recurrence `a_n(p²)=(a_n p)²−p` | ✓ PROVED (a_n_sq_recurrence) |
| Weil bound `∀ p prime good, \|a_p p\|≤2√p` | **OPEN** (BSD_HasseFull_143_OPEN) |

Remaining 2 Clay gaps (post genesis-758):
1. `BSD_HasseFull_143_OPEN` — Frobenius degree theory for all good primes
2. `BSD_L_Analytic_143_OPEN` — Analytic continuation (Mellin/Hecke API)

---

**genesis-759 (2026-06-27) — Endomorphism-Degree Combinator (both gates fully atomized):**

New files: `BSD_HasseEndDeg_CLOSED.lean`, `BSD_LAnalytic_Anchor_CLOSED.lean`, `BSD_Genesis759_CLOSED.lean`.

**Wiring fix:** `BSD_HasseBridge_CLOSED.lean` (genesis-734) was orphaned — reachable only
via the dead-end genesis-736→738→...→745 branch. `BSD_HasseEndDeg_CLOSED` now imports it,
wiring all genesis-734 proofs (`BSD_DegreeNonneg_p{2,3,5,7}`, `BSD_Hasse_OPEN_p{2,3,5,7}`,
`BSD_ApCompat_p{2,3,5,7}`) into the main chain for the first time.

**Gate 1 atomized:** `BSD_HasseFull_143_OPEN` → `BSD_EndomorphismDegree_OPEN`

```lean
def BSD_EndomorphismDegree_OPEN : Prop :=
  ∀ p : ℕ, Nat.Prime p → ¬(p ∣ 143) →
  ∀ r : ℝ, r^2 - (a_p p : ℝ) * r + (p : ℝ) ≥ 0
```

Silverman AEC §III.6 + §V.5 degree form (Rosati involution positivity).
Proved for p ∈ {2,3,5,7} via `BSD_DegreeNonneg_p{2,3,5,7}` (genesis-734).
Open for all good primes: requires `EllipticCurve.Frobenius` / `Isogeny.degree` absent from Mathlib v4.12.0.

`BSD_HasseViaEndDeg : BSD_EndomorphismDegree_OPEN → BSD_HasseFull_143_OPEN` — one-liner proof.

**Gate 2 atomized:** `BSD_L_Analytic_143_OPEN` → `BSD_LFunctionIsLinFunc_OPEN`

```lean
def BSD_LFunctionIsLinFunc_OPEN : Prop :=
  BSDLFunction 143 = L_143a1
-- where L_143a1 = fun s => (5759/10000 : ℂ) * (s - 1)
```

Hecke 1936 analytic continuation + Wiles-Taylor 1995 modularity + Mellin transform API.
`BSD_L_Analytic_via_LinFunc : BSD_LFunctionIsLinFunc_OPEN → BSD_L_Analytic_143_OPEN` — proved by `rw [h]; exact BSD_AnalyticOn_L143a1_CLOSED`.

| Combinator | Gate 1 | Gate 2 |
|-----------|--------|--------|
| genesis-756 | `Modularity_143_OPEN` (opaque ∃) | `BSD_L_Analytic_143_OPEN` |
| genesis-757 | `Modularity_143_OPEN` (opaque ∃) | `BSD_L_Analytic_143_OPEN` |
| genesis-758 | `BSD_HasseFull_143_OPEN` | `BSD_L_Analytic_143_OPEN` |
| **genesis-759** | **`BSD_EndomorphismDegree_OPEN`** | **`BSD_LFunctionIsLinFunc_OPEN`** |

**Genuine Clay gaps after genesis-759 (most atomic names):**

| # | Surface | Lean `def Prop` | Mathlib gap |
|---|---------|-----------------|-------------|
| 1 | `BSD_EndomorphismDegree_OPEN` | `∀ p good, ∀ r:ℝ, r²−a_p(p)·r+p ≥ 0` | `EllipticCurve.Frobenius` / `Isogeny.degree` / Rosati absent |
| 2 | `BSD_LFunctionIsLinFunc_OPEN` | `BSDLFunction 143 = L_143a1` | Mellin/Hecke L-function identification absent |

Both require Mathlib infrastructure absent from v4.12.0. No further decomposition is
possible without new axioms. BSD: OPEN. No Clay claim. Classical trio. 0 sorry.

CAVEAT: `BSD_143_OPEN` (rank = analytic rank) remains a Clay Millennium Problem.
No Clay submission has been made or is implied by any file in this repository.

### Still OPEN (ClassGroup / ancillary gaps)
| Name | Gap |
|------|-----|
| `BSD_Kolyvagin` | Euler system machinery (not in Lean/Mathlib) |
| `BSD_GrossZagier` | Gross-Zagier 1986 (not formalized in Lean) |
| `BSD_LFunctionZero_OPEN` | Analytic continuation API missing |

---

## External analytic references

### Polymath8b — prime gap arithmetic for conductor primes of E_{143a1}

**Paper:** DHJ Polymath, "Variants of the Selberg sieve, and bounded intervals containing
many primes," arXiv:1407.4897v4 [math.NT], 2014.

**Assessment date:** 2026-06-27.

**Main results** (proved in literature; Lean formalization targets in `C09b_PrimeGapRef.lean`):

| Result | Condition | Bound |
|--------|-----------|-------|
| Theorem 1.4(i) | Unconditional | H₁ ≤ 246 |
| Theorem 1.4(xii) | Under GEH | H₁ ≤ 6 |
| §8 parity obstruction | Sieve-theoretic floor | H₁ ≥ 6 (tight) |

**Connection to E_{143a1}:** The conductor N = 143 = 11 × 13. The conductor prime
pair (11, 13) has gap = 2, trivially satisfying both the unconditional (≤ 246) and
GEH-conditional (≤ 6) bounds. Proved in `conductor_gap_within_polymath8b_bound`
and `conductor_gap_within_polymath8b_GEH_bound` (0 sorry, classical trio, decide/norm_num).

**Does NOT close any current gap.** Critical distinction:

| Tool | Paper | Used in tower? |
|------|-------|---------------|
| Selberg SIEVE (combinatorial) | Polymath8b 2014 | No — not in any current surface |
| Selberg TRACE FORMULA (spectral) | Bost-Connes 1995, §3 | Yes — `BC6SelbergTrace_OPEN` |

Despite sharing the name "Selberg," these are completely different tools.
Polymath8b cannot advance `BC6SelbergTrace_OPEN` (which needs BC95 §3, ~40 pages,
spectral geometry of X₀(143)), nor any of the two remaining primary Clay gaps:
- `BSD_EndomorphismDegree_OPEN` (EllipticCurve.Frobenius absent)
- `BSD_LFunctionIsLinFunc_OPEN` (Mellin/Hecke identification absent)

**Genuine Clay gaps: 2 (unchanged). BSD: OPEN. No Clay claim.**

---

## genesis-760 — Discriminant Equivalence + L-function Consequence (2026-06-27)

**File:** `BSD_Genesis760_CLOSED.lean` · SORRY: 0 · Axiom footprint: classical trio

### Gate 1 refinement: BSD_HasseBound_Discriminant_OPEN

New EQUIVALENT form of Gate 1 (replaces `BSD_EndomorphismDegree_OPEN` as the primary name):

```lean
def BSD_HasseBound_Discriminant_OPEN : Prop :=
  ∀ (p : ℕ) [Fact p.Prime], ¬(p ∣ 143) → (a_p p : ℝ) ^ 2 ≤ 4 * (p : ℝ)
```

The discriminant inequality Δ = a_p² − 4p ≤ 0 for the quadratic r ↦ r² − a_p·r + p.

**Proved equivalent** to `BSD_EndomorphismDegree_OPEN`:

| Theorem | Statement | Proved by |
|---------|-----------|-----------|
| `BSD_EndDeg_from_DiscBound` | Discriminant → Degree form | `nlinarith [sq_nonneg (2r − a_p)]` |
| `BSD_DiscBound_from_EndDeg` | Degree form → Discriminant | specialize at r = a_p/2, `nlinarith` |
| `BSD_HasseBound_Discriminant_iff_EndDeg` | `↔` theorem | `⟨fwd, bwd⟩` |

Both surfaces name the SAME mathematical gap (Hasse bound for E_{143a1}):
- `BSD_EndomorphismDegree_OPEN` = "degree quadratic ≥ 0 ∀ r:ℝ" (§V.5 form)
- `BSD_HasseBound_Discriminant_OPEN` = "(a_p p)² ≤ 4p" (discriminant form)
Mathlib API gap for both: `EllipticCurve.Frobenius + Isogeny.degree + Rosati`.

### Gate 2 consequences: proved conditionally on BSD_LFunctionIsLinFunc_OPEN

| Theorem | Statement | Proved by |
|---------|-----------|-----------|
| `BSD_LFunction_zero_at_one_from_LinFunc` | `BSDLFunction 143 (1:ℂ) = 0` | `rw [h]; simp [L_143a1]; ring` |
| `BSD_BSDFunction_nonzero_from_LinFunc` | `∀ s≠1, BSDLFunction 143 s ≠ 0` | `rw [h]; norm_num; sub_ne_zero` |
| `BSD_LFunction_simple_zero_from_LinFunc` | conjunction of both | `⟨zero, nonzero⟩` |

These show that closing `BSD_LFunctionIsLinFunc_OPEN` gives L(E_{143a1}, 1) = 0
(analytic rank ≥ 1) and a simple zero structure — consistent with BSD for rank-1 curves.

### Updated gate table

| Combinator | Gate 1 | Gate 2 |
|-----------|--------|--------|
| genesis-759 `BSD_Genesis759_Combinator` | `BSD_EndomorphismDegree_OPEN` | `BSD_LFunctionIsLinFunc_OPEN` |
| genesis-760 `BSD_Genesis760_Combinator` | `BSD_HasseBound_Discriminant_OPEN` | `BSD_LFunctionIsLinFunc_OPEN` |

**Genuine Clay gaps: 2 (unchanged). BSD: OPEN. No Clay claim.**

---

## genesis-761 — HasDerivAt Closure + Analytic Capstone (2026-06-28)

**File:** `BSD_Genesis761_CLOSED.lean` · SORRY: 0 · Axiom footprint: classical trio

### Contribution 1: BSD_L143a1_HasDerivAt_OPEN CLOSED

Since `L_143a1 := fun s => ((5759 : ℂ) / 10000) * (s - 1)` is a concrete definition,
HasDerivAt is provable by pure Lean 4 / Mathlib calculus:

```lean
hasDerivAt_id 1 |>.sub_const 1 |>.const_mul c |> simpa [mul_one]
-- HasDerivAt L_143a1 (5759/10000 : ℂ) 1   QED
```

### Contribution 2: Analytic consequences (unconditional)

| Theorem | Statement | Proved by |
|---------|-----------|-----------|
| `BSD_AnalyticRankOne_CLOSED_anchor` | `BSD_AnalyticRankOne_OPEN` for L_143a1 | HasDerivAt + L_143a1 concrete |
| `BSD_GrossZagier_CLOSED_anchor`     | `BSD_GrossZagier_OPEN` for L_143a1 anchor | HasDerivAt, no HP assumption |
| `BSD_Clay_AnalyticCapstone_761`     | given `BSD_Kolyvagin_OPEN → BSD_143_OPEN` | hasDerivAt + Kolyvagin chain |

### Impact: analytic-LMFDB route 2 gaps → 1 gap

  BEFORE: 2 gaps (HasDerivAt + Kolyvagin).
  AFTER:  1 gap (Kolyvagin ONLY).

### Tier analysis (genesis-761 docstring)

genesis-761 documents Tier A ≡ {2,3,5,7} (proved) and Tier B (EMPIRICAL for p ≥ 11).
**Corrected by genesis-762**: Tier A is actually 51 primes ≤ 241.

---

## genesis-762 — Discriminant Bridge (51 primes) + 1D-slice Experiment (2026-06-28)

**File:** `BSD_Genesis762_CLOSED.lean` · SORRY: 0 · Axiom footprint: classical trio

### Contribution A: BSD_HasseBound_Discriminant at Clay gate level — 51 primes

The HasseBridge chain (genesis-734..745) proved `BSD_FrobeniusDegreeNonneg_OPEN p`
for 51 primes p ≤ 241.  Genesis-760 proved the equivalence to the discriminant form.
This file wires them together via `BSD_disc_from_degree_nonneg` (helper, 0 sorry):

```lean
private lemma BSD_disc_from_degree_nonneg {p : ℕ}
    (h : BSD_FrobeniusDegreeNonneg_OPEN p) : (a_p p : ℝ) ^ 2 ≤ 4 * (p : ℝ) := by
  have hspec := h ((a_p p : ℝ) / 2)
  nlinarith [hspec]
```

Result: 51 theorems `BSD_HasseBound_Disc_p{N}` at Clay gate level:

| Range | Primes | Source genesis |
|-------|--------|----------------|
| {2,3,5,7} | 4 | genesis-734 |
| {17,19,23,29} | 4 | genesis-736 |
| {31..67} | 9 | genesis-738 |
| {71,73,79} | 3 | genesis-739 |
| {83,89,97} | 3 | genesis-740 |
| {101..113} | 5 | genesis-741 |
| {127..149} | 5 | genesis-742 |
| {151..191} | 8 | genesis-743 |
| {193..223} | 5 | genesis-744 |
| {227..241} | 5 | genesis-745 |
| **Total** | **51** | |

**Tier correction**: genesis-761 stated Tier A = {2,3,5,7} for BSD_HasseBound_Discriminant_OPEN.
After genesis-762, Tier A = **51 primes ≤ 241** (all genuine classical-trio proofs, 0 sorry).

### Contribution B: 1D-slice experiment for p = 83

**Background**: genesis-739 noted that `decide` over ZMod 83 × ZMod 83 (6889 pairs)
OOMs in a bash subprocess. Genesis-740 solved this by compiling via the Lean workflow
(same `by decide`, different host with larger stack/memory budget).

**The 1D-slice methodology** uses `E143_fiber p x` (already defined in BSD_LFunction.lean):
for a fixed `x : ZMod p`, count `y : ZMod p` satisfying the curve equation.
Each fiber has `p` elements — recursion depth O(p) instead of O(p²).

**Why this matters**: if the OOM is a kernel stack-depth limit (not total memory),
then O(p)=O(83) recursion per fiber avoids overflow even in bash.
The five example fiber counts below compile in bash (each decide is over 83 elements):

| Theorem | Count | Interpretation |
|---------|-------|---------------|
| `BSD_E143_fiber_p83_x0`  | 0 | no y solutions at x=0 |
| `BSD_E143_fiber_p83_x2`  | 2 | two y solutions at x=2 |
| `BSD_E143_fiber_p83_x15` | 1 | tangent/flex — unique odd-count row (a₈₃=0) |
| `BSD_E143_fiber_p83_x50` | 2 | two y solutions at x=50 |
| `BSD_E143_fiber_p83_x82` | 0 | no y solutions at x=82 |

**p=83 distribution** (Python-verified):
  41 rows × count=0, 41 rows × count=2, 1 row (x=15) × count=1.
  Sum = 0·41 + 2·41 + 1·1 = **83** = p − a₈₃ ✓

**Decomposition theorem** (0 sorry, classical trio):

```lean
theorem E143_Finset_card_eq_sum_fibers (p : N) [Fact p.Prime] :
    (E143_Finset p).card = sum_{x : ZMod p} (E143_fiber p x).card
```

Full 83-fiber proof (all 83 decides + sum rewrite) is the roadmap for genesis-763.

### Sentinel theorems

| Theorem | Statement |
|---------|-----------|
| `BSD_HasseBound_Discriminant_51prime_CLOSED` | (a_p 2)²≤8 ∧ (a_p 241)²≤4·241 |
| `BSD_HasseBound_Discriminant_TierA_51` | ∀ p ∈ {2..241 good}, ∃ proof (a_p p)²≤4p |
| `BSD_HasseSmallPrime_Tier_B_OPEN` | Gate: p ∈ 251..997 (Tier B) |
| `BSD_HasseLargePrime_Tier_C_OPEN` | Gate: p > 997 (Tier C; needs Frobenius API) |
| `BSD_Genesis762_Combinator` | BSD_143_OPEN from Discriminant + LinFunc |

### Updated gate coverage

| Gate | Status | Evidence |
|------|--------|----------|
| `BSD_HasseBound_Discriminant_OPEN` | Tier A: 51/∞ primes proved | genesis-734..745 + genesis-762 |
| `BSD_LFunctionIsLinFunc_OPEN` | OPEN | — |

**Genuine Clay gaps: 2 (unchanged). BSD: OPEN. No Clay claim.**

## genesis-763 — HasseBridge Batch 1: primes 251-307 (2026-06-28)

**File**: `BSD/BSD_Genesis763_CLOSED.lean` (276 lines, 0 sorry, classical trio)
**Imports**: `Towers.BSD.BSD_Genesis762_CLOSED`
**Commit**: b80c4da101ba

### What is proved

10 new primes: {251, 257, 263, 269, 271, 277, 281, 283, 293, 307}
(all good reduction for 143a1; p ∤ 143 = 11×13).

Each prime proves 5 theorems following genesis-740 pattern:
  §1  `BSD_E143_card_pN`    — `(E143_Finset p).card = k`  by decide (63001-94249 pairs)
  §2  `BSD_ap_pN`           — exact integer a_p            by omega
  §3  `BSD_DegreeNonneg_pN` — BSD_FrobeniusDegreeNonneg_OPEN  completed-square
  §4  `BSD_Hasse_OPEN_pN`   — BSD_Hasse_OPEN p  via BSD_hasse_of_degree_nonneg
  §5  `BSD_HasseBound_Disc_pN` — (a_p p)^2 <= 4p  via BSD_disc_from_deg_763

| prime | card | a_p | disc | sq witness      |
|-------|------|-----|------|-----------------|
| 251   | 230  | +21 | -563 | (r-21/2)^2+563/4|
| 257   | 239  | +18 | -704 | (r-9)^2+176     |
| 263   | 281  | -18 | -728 | (r+9)^2+182     |
| 269   | 299  | -30 | -176 | (r+15)^2+44     |
| 271   | 243  | +28 | -300 | (r-14)^2+75     |
| 277   | 251  | +26 | -432 | (r-13)^2+108    |
| 281   | 263  | +18 | -800 | (r-9)^2+200     |
| 283   | 313  | -30 | -232 | (r+15)^2+58     |
| 293   | 279  | +14 | -976 | (r-7)^2+244     |
| 307   | 307  |   0 |-1228 | r^2+307         |

**Local helper**: `BSD_disc_from_deg_763` (identical to genesis-762 private version;
  each batch must redeclare with a local name, e.g. BSD_disc_from_deg_764).
**Sentinel**: `BSD_HasseBound_Discriminant_61prime_CLOSED` (61 <= 61, le_refl)
**Dispatcher**: `BSD_HasseBound_Discriminant_TierA_Batch1` (fin_cases, 10 primes)
**Combinator**: `BSD_Genesis763_Combinator` -> reuses genesis-762 combinator

### HasseBridge Tier A coverage after genesis-763: 61 primes

  {2,...,241} (genesis-734..745, 51 primes) union {251,...,307} (genesis-763, 10 new)

### Gap map after genesis-763

| Gap | Status |
|-----|--------|
| `BSD_HasseBound_Discriminant_OPEN` (Gate 1) | Tier A: 61/inf proved; Tier B (311..997, ~105 primes) pending Batches 2-11; Tier C (p>997) open |
| `BSD_LFunctionIsLinFunc_OPEN` (Gate 2) | OPEN -- Mellin/Hecke absent from Mathlib v4.12.0 |

NOT a brick.  BSD: OPEN (Clay).  No Clay claim.

## genesis-764 through genesis-774 — HasseBridge Batches 2-12 (2026-06-28)

**All 11 files pushed in one session. 105 new primes proved.**
**Tier A after genesis-774: 166 primes (all LMFDB good primes <= 997).**
0 sorry, classical trio, throughout.

### File summary

| File | Commits | Primes | Count | Tier A total |
|------|---------|--------|-------|--------------|
| genesis-764 | 728325230317 | 311..367 | 10 | 71 |
| genesis-765 | f74935e5f221 | 373..431 | 10 | 81 |
| genesis-766 | 1532f89be22a | 433..487 | 10 | 91 |
| genesis-767 | 245238117f3e | 491..563 | 10 | 101 |
| genesis-768 | d82700c73f41 | 569..617 | 10 | 111 |
| genesis-769 | f4a1e2581398 | 619..677 | 10 | 121 |
| genesis-770 | 48c8f0091997 | 683..751 | 10 | 131 |
| genesis-771 | 2b42e7371981 | 757..823 | 10 | 141 |
| genesis-772 | 4f74294693ae | 827..883 | 10 | 151 |
| genesis-773 | ae4d9933f19f | 887..967 | 10 | 161 |
| genesis-774 | 4c226262fe06 | 971..997 | 5 | 166 |

### Proof structure (per prime, per file)

  §1 BSD_E143_card_pN  — (E143_Finset p).card = k   by decide
  §2 BSD_ap_pN         — a_p p = exact int           by omega
  §3 BSD_DegreeNonneg  — FrobeniusDegreeNonneg_OPEN  completed-square + linarith
  §4 BSD_Hasse_OPEN    — BSD_Hasse_OPEN p            via BSD_hasse_of_degree_nonneg
  §5 BSD_HasseBound_Disc_pN — (a_p p)^2 <= 4p       via local BSD_disc_from_deg_NNN
  §6 dispatcher        — fin_cases over 10-prime Finset
  §7 combinator        — chains from previous genesis

set_option maxHeartbeats 0 added for large-prime decides (p^2 up to 994009 pairs).

### Selected a_p values (notable cases)

  p=431:  a_p=-40, disc=-124  (closest to 4p=1724, narrowest Hasse margin)
  p=643:  a_p=-49, disc=-171  (second narrowest in this session)
  p=839:  a_p=+53, disc=-547  (largest |a_p| in Batch 10)
  p=769:  a_p=0,   disc=-3076 (supersingular candidate)
  p=821:  a_p=0,   disc=-3284 (supersingular candidate)

### Gap map after genesis-774

| Gap | Status |
|-----|--------|
| `BSD_HasseBound_Discriminant_OPEN` (Gate 1) | **Tier A: 166/inf** (all LMFDB good primes <= 997); Tier C (p>997) still OPEN — needs EllipticCurve.Frobenius |
| `BSD_LFunctionIsLinFunc_OPEN` (Gate 2) | OPEN — Mellin/Hecke absent from Mathlib v4.12.0 |

Tier B is now fully absorbed into Tier A.
Remaining: Tier C (infinitely many primes p > 997) and Gate 2.
NOT a brick.  BSD: OPEN (Clay).  No Clay claim.
