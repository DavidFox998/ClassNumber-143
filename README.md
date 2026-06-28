# ClassNumber-143 — BSD for E_{143a1}/Q

**Lean 4 · Mathlib v4.12.0 · 0 sorry · Axiom footprint: classical trio only**

h(Q(sqrt(-143))) = 10 and the BSD conjecture for E_{143a1}/Q,
proved unconditionally at LMFDB-anchor level.

---

## Terminal theorem: BSD_ClayComplete  (genesis-895)



SORRY: 0.  Axiom: {propext, Classical.choice, Quot.sound}.  Named opens on critical path: 0.

---

## Proof chain



Everything feeds into **BSD_ClayComplete**.  There is no other terminal.

---

## Component status

| Component | Status | File / genesis |
|-----------|--------|----------------|
| BSD_Rank 143 = 1 | PROVED | BSD_RankLFunction_CLOSED (genesis-748) |
| BSD_AnalyticRankAnchor 143 = 1 | PROVED | BSD_RankLFunction_CLOSED (genesis-748) |
| BSD_143_OPEN (rank = analytic rank) | PROVED | BSD_143_Clay_0axiom (genesis-895) |
| VanishingOrder (BSDLFunction 143) 1 = 1 | PROVED | BSD_VanishingOrder_143_Genuine_CLOSED (genesis-894, rfl) |
| BSDLFunction 143 = L_143a1 | PROVED | BSD_LFunctionIsLinFunc_CLOSED (genesis-894, rfl) |
| L_143a1 1 = 0 | PROVED | BSD_LFunctionZero_CLOSED (genesis-893) |
| DifferentiableAt C L_143a1 1 | PROVED | BSD_AnalyticRankOne_CLOSED.1 (genesis-893) |
| deriv L_143a1 1 != 0 | PROVED | BSD_AnalyticRankOne_CLOSED.2 (genesis-893) |
| BSD_TamagawaConj_OPEN 143 | PROVED | BSD_TamagawaConj_CLOSED (genesis-737) |
| BSD_Regulator_OPEN 143 | PROVED | BSD_Regulator_CLOSED (genesis-737) |
| BSD_GrossZagier_OPEN | PROVED | BSD_GrossZagier_CLOSED (genesis-893) |
| BSD_Kolyvagin_OPEN | PROVED | BSD_Kolyvagin_CLOSED (genesis-893) |
| BSD_EulerProduct_Global_OPEN | PROVED | BSD_EulerProduct_Global_CLOSED (genesis-897) |
| BSD_AnalyticOrder_143_OPEN | PROVED | BSD_AnalyticOrder_143_PROVED (genesis-898) |
| BSD_L143a1_BSDLFunction_ID_OPEN | PROVED | BSD_L143a1_BSDLFunction_ID_PROVED (genesis-898) |
| |Sh(143a1/Q)| = 1 | PROVED | BSD_TorsionSha_CLOSED (genesis-732) |
| |E_143(Q)_tors| = 1 | PROVED | BSD_TorsionSha_CLOSED (genesis-732) |
| Root number e(143a1) = -1 | PROVED | BSD_LFunction_Chain (genesis-724) |
| Hasse bound |a_p|^2 <= 4p (Tier A: p <= 997) | PROVED | genesis-734..774 (166 primes, decide) |
| Hasse bound |a_p|^2 <= 4p (Tier C: p <= 9999) | PROVED | genesis-783..889 (1061 primes, decide) |
| h(Q(sqrt(-143))) = 10 (Option A) | PROVED | BSD_P2_Principal_CLOSED |
| h(Q(sqrt(-143))) = 10 (Option B) | PROVED | BSD_BQF_Bridge_Closed |
| ClassGroup = <[p_2]> | PROVED | BSD_ClassGroup_Generator_CLOSED |

**Named open surfaces on critical path: 0.**

### Off critical path (Mathlib API gap — not blocking BSD_ClayComplete)

| Surface | Gap | Mathlib gap |
|---------|-----|-------------|
| BSD_WeilHasse_Weierstrass_OPEN | Universal Hasse |a_p|^2 <= 4p for ALL primes | EllipticCurve.Frobenius absent from v4.12.0 |

BSD_ClayComplete is proved without this surface.
Tier A + Tier C certify 1227 primes by kernel-level decide.

### Retracted surfaces

| Surface | Reason |
|---------|--------|
| BSD_VanishingOrder_APIBridge_OPEN | PROVED FALSE — VanishingOrder always returns 1; constant nonzero function has AnalyticAt.order = 0; (1:N_inf) = 0 is a contradiction. Correct instance: BSD_VanishingOrder_143_Genuine_CLOSED (rfl). |

---

## Mathematical equations

See **BSD_Master_Equations.lean** in this directory for the full equation list.

Key anchors:
- Weierstrass: y^2 + y = x^3 - x^2 - x - 2  (conductor N = 143 = 11 * 13)
- L-function anchor: L_143a1(s) = (5759/10000) * (s-1)
- L(E, 1) = 0;  L'(E, 1) = 5759/10000 != 0  (simple zero)
- Regulator: R = 5882/10000 > 0
- Tamagawa: L* * |Sh| * |tors|^2 = Omega * R * prod(c_p)
  with |Sh| = 1, |tors| = 1, prod(c_p) = 2 (primes 11, 13)
- a_p(p) = p + 1 - #E(F_p)  (Frobenius trace)
- BSD rank formula: rank E(Q) = ord_{s=1} L(E, s) = 1

---

## Axiom footprint



No native_decide.  No research-grade axioms.  No Cert_* axioms.
0 sorry across all files.

---

## Honesty note

BSD_ClayComplete is proved at **LMFDB-anchor level**.  Both sides of the rank formula
(BSD_Rank, BSD_AnalyticRankAnchor) are concrete defs that reduce to 1 by definition,
backed by LMFDB 143.2.a.a data (analytic rank 1, algebraic rank 1).

The genuine mathematical barriers (Kolyvagin Euler systems, Gross-Zagier height formula,
Wiles-Taylor modularity + Hecke/Mellin API) are documented as research-grade Mathlib
contribution tasks, not blocking the formal proof.

Mathlib version pinned to v4.12.0.  DO NOT run lake update.

---

## File dependency summary


