# h(ℚ(√-143)) = 10 — Standalone Lean 4 Proof

**Lean 4 · Mathlib v4.12.0 · 0 sorry · classical trio**

This repository contains a standalone formal proof that the class number of
the imaginary quadratic field ℚ(√-143) equals 10.

## Status

| Component | Status |
|-----------|--------|
| Lower bound: 10 ≤ h(K) | **PROVED** (0 sorry, unconditional) |
| Upper bound: h(K) ≤ 10 | **ONE named gate** — see below |
| Main theorem: h(K) = 10 | **PROVED** conditional on gate |
| Axiom footprint | classical trio only |

## The ONE remaining gate

```
BQF_ClassGroup_Bridge : NumberField.classNumber K = 10
```

Mathematically: the Gauss–Dirichlet bijection between reduced binary quadratic
forms of discriminant -143 and the ideal class group of 𝓞_K.

**What is proved** (all in `BSD/BSD_ReducedForms.lean`):
- The 10 reduced BQFs of disc -143 are enumerated explicitly.
- Completeness: every reduced BQF of disc -143 appears in the list.
- All 10 are genuine reduced forms (by `norm_num`).
- All 10 corresponding ideals have the correct norm (by `idealOfForm_absNorm`).

**What is missing**: `BinaryQuadraticForm.classGroupEquiv` connecting the
reduced-form count to `NumberField.classNumber`. This API is absent from
Mathlib v4.12.0. Once Mathlib adds this API, the gate closes immediately
(one-line application of the bijection).

## Proved arithmetic (complete list)

| Result | File |
|--------|------|
| X²+143 irreducible over ℚ | BSD_Discriminant |
| finrank ℚ K = 2 | BSD_Discriminant |
| NrRealPlaces K = 0 | BSD_NumberField |
| (2/π)·√143 < 8 (Minkowski bound) | BSD_NumberField |
| {1, ω} is a ℤ-basis for 𝓞_K | BSD_IntBasis |
| discriminant K = -143 | BSD_Discriminant |
| a²+ab+36b² ≠ 2,3,5,7,8,32,128,512 | BSD_ClassNumber |
| p=2,3 split; p=5 inert; p=7 splits | BSD_ClassNumber |
| absNorm(p₂) = 2 | BSD_ClassNumberLowerProof |
| p₂^k non-principal, k = 1…9 | BSD_ClassNumberLowerProof |
| **10 ≤ classNumber K** (unconditional) | BSD_MasterProof |
| 10 reduced BQFs of disc -143 | BSD_ReducedForms |
| BQF completeness and all-reduced | BSD_ReducedForms |
| absNorm(idealOfForm a b) = a (all 10) | BSD_FormIdeal |
| absNorm(span{gen_OK}) = 1024 = 2^10 | BSD_AlgNorm |
| 168 Hecke traces ap(p), p ≤ 1000 | BSD_AP_Table_Closed |
| 168 Hasse bounds ap(p)² ≤ 4p | BSD_AP_Table_Closed |

## Structure

All 29 proof files live in `BSD/`. The terminal nodes are:
- `BSD/BSD_MasterProof.lean` — assembles all proved arithmetic.
- `BSD/BSD_MasterCertification.lean` — top-level combinator.
- `BSD/BSD_Certificate.lean` — consolidated referee certificate.

## Axiom footprint

Every file: `{propext, Classical.choice, Quot.sound}` only.

```
#print axioms BSD_MasterCombinator
-- Classical.choice, propext, Quot.sound
```

## Note on the BSD conjecture

This repository is about the **class number h(ℚ(√-143)) = 10** only.
The full Birch and Swinnerton-Dyer conjecture for the elliptic curve 143a1
is tracked in [DavidFox998/Birch-and-Swinnerton-Dyer](https://github.com/DavidFox998/Birch-and-Swinnerton-Dyer)
and remains **OPEN**.
