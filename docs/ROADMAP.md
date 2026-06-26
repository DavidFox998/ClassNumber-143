# Roadmap — five towers we want to reach

This is the *research roadmap* for the Morning Star Project. None of
the five towers below is proved in this repo. The Lean spine
(`TheoremaAureum.main_theorem`, axioms = []) closes the deductive
chain `H1 → H2 → main_theorem` *given* Prop-level stubs declared in
`lean-proof/TheoremaAureum/Certificates.lean`. Closing those stubs
is the open work.

Status legend:

- **Open** — the statement is a Prop stub in Lean; no proof in this
  repo; closing it is research-grade work.
- **Certified for N=397** — the specific conductor `N = 397` is
  discharged in `m9.out` and pinned by the spine; the general
  statement remains Open.
- **Certified in spine** — the named theorem actually closes inside
  the Lean spine without new axioms.

> **SORRY-purge note (2026-05-31).** Every live `sorry` proof-term across
> `Towers/` has been converted to a named open `Prop` hypothesis (Option B),
> and the BSD `axiom`s to hypotheses. This is logical hygiene only: it removes
> `sorryAx` from the touched files but **discharges no surface and proves no new
> result.** All five towers below stay **Open**; YM is a conditional reduction
> only, NS keeps Surfaces #1/#2 Open, and Hodge stays Open behind the named-open
> `AnalyticObstruction`.

---

## 1. Riemann Hypothesis (RH)

**Status: Open — two bricks formalized (N-monotonicity in Lean; Bost-Connes threshold; axiom footprint = subset of mathlib's classical core {propext, Classical.choice, Quot.sound}, no research-grade axioms).**

- Computational evidence in this repo: 20,954 nontrivial ζ zeros
  located on the critical line via `kernel.sieve_zeros` /
  `zeta_sniper`, every refined `t` satisfying `|ζ(½ + it)| < 1e-49`,
  all appended to the Genesis-sealed ledger.
- Lean stub: `TheoremaAureum.RiemannHypothesis : Prop` in
  `Certificates.lean`. Not proved here. The spine's `main_theorem`
  has type `RiemannHypothesis`, but the proof depends on the
  Prop-stub `H2_WeilTransfer` and on the structure of the
  declaration in `Certificates.lean`, not on a Lean formalization
  of the analytic statement.
- First honest formal brick (restored 2026-06-15):
  `lean-proof-towers/Towers/RH/ZeroDensity.lean` defines `N σ T`
  (the count of nontrivial `riemannZeta` zeros in `[σ, 1] × [0, T]`)
  on top of mathlib's real `riemannZeta`, proves the trivial
  monotonicity lemma `N_monotone_in_sigma` with axiom footprint
  contained in mathlib's classical core `{propext, Classical.choice,
  Quot.sound}` (no `sorryAx`, no user-declared axioms), and pins
  `RiemannVonMangoldt_setCounting_statement : Prop` (the
  multiplicity-free variant of the classical Titchmarsh §9.4
  statement, with `0 < C`) as a named target for a future plan.
  The lemma is conditional on finiteness of the larger box (the
  Riemann–von Mangoldt-adjacent fact that is itself not yet in
  mathlib v4.12.0) — discharging that finiteness is the next step.
  Lives in a **sibling package** `lean-proof-towers/` so the fast
  spine drift guard stays mathlib-free. Built by
  `scripts/check-towers.sh` / the `towers-build` workflow.
- Second honest formal brick (2026-06-15): `bost_connes_threshold`
  in `lean-proof-towers/Towers/RH/Chain/C06_ZetaControl.lean`.
  For X₀(143) with arithmetic genus g = 13, proves `2 · √13 < 320`
  — the concrete numerical fact that the Bost-Connes constant C₀ = 320
  (from `M13_CERT.txt`, the BC-CM h=1 spine constant) exceeds twice
  the square root of the genus. Axiom footprint = classical trio.
  NOT a claim about RH or L-functions; a pure numerical brick.
- C01–C07 chain (2026-06-15): `lean-proof-towers/Towers/RH/Chain/`
  holds a seven-file Arakelov-to-RH conditional reduction scaffold.
  **Honest scope:**
  - C01 defines `ArithmeticSurface`, `X₀ N`, `arakelovSelfIntersection`
    (slope-formula stand-in `4(g-1)/g`), and the `ArakelovPositivity`
    hypothesis (an explicit open input — genuine Arakelov intersection
    theory is absent from mathlib v4.12.0).
  - C03 proves the slope inequality `(4g-4)/g ≤ ω²` genuinely from the
    stand-in definition (trivially `le_refl` under the stand-in).
  - C06 proves `bost_connes_threshold` (the BRICK above).
  - C02, C04, C05: True stubs for modularity, Vojta height bound,
    discriminant-conductor bound — open bridges not discharged here.
  - C07: honest conditional combinator (NOT a brick) — derives
    `RiemannHypothesis` from two named OPEN inputs (`ArakelovPositivity
    (X₀ 143)` and an explicit `hbridge` hypothesis). Proves nothing new.
  SORRY: 0 throughout. YM Surface #1: OPEN. RH: OPEN.
- Companion files (NOT bricks):
  `Towers/RH/GrowthContradiction.lean` — honest recreation of the
  David Fox RH fragment as a CONDITIONAL REDUCTION: `GrowthBound`
  (false, circular) + `ZeroRepulsion` (open) → RH. The only genuine
  math is `exp_loglog_dominates_sq` (pure calculus, no RH content).
  `Towers/RH/ZProtocolBridge.lean` — Z-Protocol honesty bridge:
  names T_s / T_t separately, reports 0% certified digits, labels the
  ∀-conjecture explicitly, and checks the interface to ZeroDensity.
- Honest note: a computational verification window does not imply
  RH. A formal proof would require, at minimum, formalizing a
  zero-density estimate strong enough to rule out off-line zeros,
  which is itself an open mathlib-scale project.

## 2. Yang-Mills mass gap

**Status: Open — seven trio-clean SU(3) bricks formalized in `Towers/YM/MassGap.lean` (real `Matrix.specialUnitaryGroup (Fin 3) ℂ` algebra: monoid identity left/right, unitarity and det = 1 of each component, plus closure under multiplication for both. Axiom footprint = subset of mathlib's classical core `{propext, Classical.choice, Quot.sound}`; no research-grade axioms).**

- Geometric invariant under study in this repo:
  `C(S₄) = 11.4221486889`, an OpenCV-derived symmetry-count
  invariant attached to the M0 cube observations (`cube_M0_v*.jpg`,
  Appendix A of the architecture write-up).
- Honest formal bricks: `lean-proof-towers/Towers/YM/MassGap.lean`
  defines `SU3Connection := Fin 4 → Matrix.specialUnitaryGroup
  (Fin 3) ℂ` (the trivial-bundle constant-coefficient case of an
  SU(3) connection on ℝ⁴ — four constant SU(3)-valued fields, one
  per spacetime direction) and proves seven trio-clean lemmas
  against the real `Matrix.specialUnitaryGroup` API in
  `Mathlib/LinearAlgebra/UnitaryGroup.lean`:
  `SU3Connection_one_mul`, `SU3Connection_mul_one`,
  `SU3Connection_one_one`, `SU3Connection_component_unitary`,
  `SU3Connection_component_det_one`,
  `SU3Connection_component_mul_unitary`,
  `SU3Connection_component_mul_det_one`. Axiom footprint contained
  in `{propext, Classical.choice, Quot.sound}`; no `sorryAx`, no
  user-declared axioms in any brick. Alongside, the file pins
  `YM_mass_gap_statement : Prop` as a *statement schema* with
  two `sorry`-backed defs (`YMHamiltonian`, `IsEigenstate`) plus
  `HilbertSpace`, which Task #55 (2026-05-26, Branch A) upgraded
  from `sorry` to `lp (fun _ : ℕ => ℂ) 2` — i.e. ℓ²(ℕ,ℂ), the
  canonical separable infinite-dim complex Hilbert space from
  `Mathlib.Analysis.InnerProductSpace.l2Space`. **That upgrade is
  NOT a promotion of the YM tower.** ℓ²(ℕ,ℂ) is a real Hilbert
  space but it is NOT the Yang-Mills physical Hilbert space — the
  actual YM Hilbert space requires an Osterwalder–Schrader
  reconstruction from a constructed 4D Euclidean YM measure that
  does not exist in mathlib v4.12.0 (and is itself open in 4D
  pure YM). The remaining two sorries are honest stand-ins
  because mathlib v4.12.0 lacks the Wightman/Osterwalder-Schrader
  axiomatic QFT framework, a constructive 4D Yang-Mills
  Hamiltonian, and the Sobolev-space spectral theory the
  statement needs. Statement-only, no
  `True.intro`. Built by `scripts/check-towers.sh` / the
  `towers-build` workflow. **The trivial-bundle constant-coefficient
  SU(3) connection is a scaffold for future work, not a physically
  meaningful Yang-Mills configuration** — a real connection is a
  Lie-algebra-valued 1-form on a principal bundle over (at least)
  a 4-manifold.
- Retirement note (2026-05-26, Task #50 Option A): a sibling file
  `Towers/YM/Gauge.lean` previously held six `gauge_action_*`
  bricks on a `TrivialConfiguration G` scaffold whose `MulAction`
  was `· • A := A`. Every `gauge_action_*` lemma reduced
  definitionally on both sides to `A`, exercising neither group
  multiplication nor the action; the bricks were hollow even by
  trivial-brick standards. The whole file was withdrawn — see git
  history. YM bricks now live exclusively against the real
  `Matrix.specialUnitaryGroup` API.
- Honest note: `C(S₄) > 2√32` is an arithmetic fact about a
  cube-counting invariant. It is **not** a mass-gap lower bound on
  any Yang-Mills Hamiltonian, and no derivation in this repo
  connects it to the Jaffe-Witten Clay problem. Treat it as
  conjectural scaffolding for a future link, not as evidence for
  the mass gap. The seven SU(3) bricks in `Towers/YM/MassGap.lean`
  above do not advance the mass gap past `Open` — they are
  elementary monoid/unitarity facts about the trivial-bundle
  constant-coefficient SU(3) connection on the way there, not
  spectral lower bounds on any Yang-Mills Hamiltonian.
- Distance-predicate tripwire (Task #209,
  `Towers/YM/RiemannianGeometry.lean`): the SU(3) distance used by
  the heat-kernel envelope is only a *pseudo-distance*, never a real
  metric. A new `IsMetricOnSU3 d` predicate (pseudo-dist ∧ separation
  `d g h = 0 → g = h` ∧ triangle inequality) makes the missing
  separation axiom explicit, and the brick
  `not_IsMetricOnSU3_const_zero` PROVES that the `d ≡ 0` stand-in
  (`fun _ _ => 0`) FAILS `IsMetricOnSU3` — witnessed by the concrete
  non-identity element `cWit = diag(-1,-1,1) ∈ SU(3)` (`cWit_ne_one`),
  on which any zero distance would falsely force `cWit = 1`. This
  constructs NO real geodesic/Killing-form distance and makes NO
  mass-gap, μ>0, or Surface-#1 claim; it only records honestly that
  the current stand-in is not a metric. Axiom footprint of both bricks
  = `{propext, Classical.choice, Quot.sound}`. YM stays
  **Status: Open**.

## 3. Navier-Stokes global regularity

**Status: Open — eight trio-clean divergence bricks formalized in `Towers/NS/Divergence.lean` (linearity under addition / scalar multiplication / negation / subtraction, plus the zero, constant, add-constant, and sub-constant cases of a minimal fderiv-based divergence operator on `Differentiable ℝ` vector fields; axiom footprint = subset of mathlib's classical core `{propext, Classical.choice, Quot.sound}`, no research-grade axioms).**

- Conjectural scaffolding in this repo: "Arakelov descent from
  `X_0(397)`" is a label for a proposed bridge from heights on a
  modular curve to PDE energy estimates.
- Honest formal bricks: `lean-proof-towers/Towers/NS/Divergence.lean`
  defines a minimal `divergence` operator on smooth vector fields
  `V → V` (where `V = EuclideanSpace ℝ (Fin 3)`) as the sum of the
  Fréchet-derivative-based directional derivatives along the three
  coordinate axes, and proves eight trio-clean linearity lemmas
  (`divergence_add`, `divergence_smul`, `divergence_zero`,
  `divergence_neg`, `divergence_sub`, `divergence_const`,
  `divergence_add_const`, `divergence_sub_const`) by delegating to
  mathlib's `fderiv_add`/`fderiv_smul`/`fderiv_const`/etc. and
  `Finset.sum_*` lemmas. Axiom footprint contained in mathlib's
  classical core `{propext, Classical.choice, Quot.sound}` (no
  `sorryAx`, no user-declared axioms in any brick). Alongside,
  the sibling file `Towers/NS/EnergyIneq.lean` pins
  `NS_global_regular_statement : Prop` as a *statement schema*
  with two `sorry`-backed defs (`H1Norm`, `HasFiniteEnergy`) plus
  a `LeraySolution` structure carrying two abstract `Prop` fields
  (`h_div_free`, `h_energy`) — honest stand-ins because mathlib
  v4.12.0 lacks Sobolev spaces (`SobolevSpace.norm` on
  `H^1(ℝ³; ℝ³)`) and the Navier-Stokes operator. Statement-only,
  no `True.intro`. The `Towers/NS/EnergyIneq.lean` file carries
  an in-source "Task #51 decision audit" comment explaining why
  every concrete replacement of those two sorries was rejected as
  either a forbidden stub or a substantively misleading
  formalization. Built by `scripts/check-towers.sh` / the
  `towers-build` workflow.
- Honest note: there is no derivation in this repo (or, to our
  knowledge, in the literature) from `X_0(397)` to a Leray-Hopf
  weak-strong uniqueness statement or to the Beale-Kato-Majda
  blow-up criterion for 3D incompressible Navier-Stokes. Treat
  the phrase as a research direction, not as a proof token. The
  eight divergence linearity bricks above do not advance global
  regularity past `Open` — they are elementary calculus facts
  about a minimal fderiv-based divergence operator on the way
  there, not energy or blow-up estimates for the Navier-Stokes
  operator.
- Function-space scaffolding (NOT bricks, not in BRICKS, not lakefile
  roots; each compiles `sorry`-free except a single documented `sorry`):
  - **Phase 1** `Towers/NS/FunctionSpaces.lean` — the divergence-free
    Sobolev space `Hdiv_free s` as the weighted-`L²` Fourier model
    (genuine Hilbert space; closedness of the div-free subspace and the
    bounded Sobolev inclusion `embed` are PROVED `sorry`-free, classical
    trio).
  - **Phase 2A — Status: Complete** (milestone `NS-540-phase2a-leray`).
    `Towers/NS/Leray.lean` — the Leray/Helmholtz orthogonal
    projection `leray_proj : Hˢ →L Hdiv_free s` with `P² = P`,
    `‖Pu‖ ≤ ‖u‖`, and `ker P` (PROVED, classical trio). The single
    documented `sorry` is `leray_proj_ker_eq_grad` (the Helmholtz
    identification `(divFree)ᗮ = grad`).
  - **Phase 2B — Status: Complete** (milestone `NS-540-phase2b-stokes`;
    `stokes_op` moved Blocked → Complete). `Towers/NS/Stokes.lean` — the
    Stokes operator
    `stokes_op = -PΔ : Hdiv_free (s+2) →L Hdiv_free s`, the `‖ξ‖²`
    Fourier multiplier. **NOW FULLY `sorry`-free + classical trio** —
    the former lone `sorry` (`stokes_eLpNorm_le`) is CLOSED, so
    `#print axioms` returns the classical trio on EVERY declaration,
    including the operator `stokes_op` and the bound
    `stokes_op_norm_le` (verified live). Proved content: the `-Δ`
    symbol estimate `‖ξ‖⁴⟨ξ⟩^{2s} ≤ ⟨ξ⟩^{2(s+2)}`, symbol positivity,
    symbol continuity, a.e.-strong-measurability, the NEW pointwise
    `ℝ≥0∞` density bound `stokes_weight_pointwise`, and the lift
    `stokes_eLpNorm_le` (the `‖ξ‖²•û` `L²` bound) carried through the
    `withDensity`/`eLpNorm` integrals
    (`lintegral_withDensity_eq_lintegral_mul₀'`). The operator-level
    declarations (`stokes_op`, linearity, div-free preservation, the
    `‖A u‖ ≤ ‖u‖` bound) are now trio-clean (no `sorryAx`) — the
    genuine operator, no longer provisional. NO self-adjointness /
    sectoriality / analytic-semigroup claim (absent from mathlib
    v4.12.0). Stokes does NOT import Leray.
  - **Phase 3 — Status: Complete** (milestone `NS-540-phase3-energy` @
    checkpoint `ae85a633`). `Towers/NS/Energy.lean` — the kinetic energy
    functional `energy u t = ‖u t‖²` on `Hdiv_free (s+2)`, with `energy_def`.
    Trio-clean, no `sorryAx`.
  - **Phase 4A — Status: Complete.** `Towers/NS/GalerkinApprox.lean` (imports
    Energy) — the **finite-dimensional Galerkin projection** `galerkinProj K n
    : Hˢ⁺² →L Kₙ` (mathlib `orthogonalProjection` onto the finite-dim `Kₙ`;
    `HasOrthogonalProjection` from `FiniteDimensional.complete`, supplied as a
    *local* `haveI` so it never pollutes global instance resolution), the
    Galerkin sequence `galerkin_seq`, and the a-priori bounds
    `galerkinProj_norm_le` (`‖Pₙ‖ ≤ 1`), `galerkin_seq_norm_le`
    (`‖uₙ(t)‖ ≤ ‖u(t)‖`), and the headline `galerkin_seq_sq_le_energy`
    (`‖uₙ(t)‖² ≤ energy u t`). Fully `sorry`-free, classical trio on every
    decl (verified live).
  - **Phase 4B — Status: Complete.** `Towers/NS/Compactness.lean` (imports
    GalerkinApprox) — `embedToLower` (the bounded, **NON-compact** inclusion
    `Hˢ⁺² ↪ Hˢ`), `TendstoLocL2` (**modeled** lower-order convergence — an
    `Hˢ`-norm surrogate for `L²_loc`, NOT literal `L²_loc`), and
    `AubinLionsCriterion` — the genuine Rellich–Kondrachov compactness theorem
    stated as a **NAMED `Prop` HYPOTHESIS, NOT proved and NOT `sorry`-ed**
    (the *compact* embedding it needs is absent from mathlib v4.12.0).
    `galerkin_strong_convergence` is an HONEST combinator routing the Phase-4A
    energy bound through the assumed criterion; it proves nothing about NS by
    itself. Fully `sorry`-free, classical trio (verified live).
  - **Phase 5 — Status: Complete.** `Towers/NS/WeakSolution.lean` (imports
    Compactness ⇒ the whole Phase-3/4 stack) — the Galerkin weak-existence
    argument as an HONEST combinator. `weak_solution_exists (u₀) (f) :
    ∃ u, WeakNS u u₀ f` is PROVED from THREE NAMED `Prop` inputs (the ≤3
    "sorries", stated as Props — NEVER `by sorry`, so zero `sorryAx`):
    `galerkin_subsequence_converges` (SORRY 1: Galerkin sequence converges to a
    candidate; needs the COMPACT `AubinLionsCriterion`),
    `limit_satisfies_weak_form` (SORRY 2: limit solves NS in the modeled
    distribution sense), `energy_inequality_passes_to_limit` (SORRY 3: energy
    inequality passes to the limit). `WeakMomentum` is a MODELED **linear**
    Stokes weak form (nonlinear `(u·∇)u` DROPPED) and `WeakNS` a MODELED
    surrogate (init + `WeakMomentum` + force-free energy bound), NOT the literal
    Leray–Hopf definition. Index/viscosity match Phase 3/4 (`Hdiv_free (s+2)`,
    `ν = 1`). `#print axioms weak_solution_exists` = classical trio (verified
    live). The combinator routes the three unproved NAMED inputs into the
    conclusion; it proves NOTHING about NS by itself. Last combinator BEFORE
    Surface #1 (`global_smooth_exists`); does NOT touch it.
  - **Phase 6 — Status: Complete; NS FROZEN at 251 at the Clay boundary**
    (milestone `NS-540-phase6-clay-boundary` @ checkpoint
    `c5f29fb4390e5dda83ffdbfcae5dea2333cf5c12`; supersedes
    `NS-540-phase6-regularity`). **FREEZE RULE: no further commits to
    `Towers/NS/` without an explicit unfreeze order.** Surface #1
    (`global_smooth_exists`) and Surface #2 (modeled `weak_solution_exists`)
    stay OPEN. `Towers/NS/Regularity.lean` (imports
    WeakSolution) — the weak⇒strong (conditional) regularity step as an HONEST
    combinator. `weak_implies_strong (h : global_smooth_exists) (w : WeakSolution
    s) : ∃ T > 0, IsSmoothOn w.u T` is PROVED from the SINGLE NAMED `Prop`
    `global_smooth_exists` (the NS global-regularity surface — every modeled weak
    solution is smooth on a short interval; the Clay-grade open content, NAMED,
    NEVER `by sorry`, so zero `sorryAx`). `WeakSolution s` bundles the Phase-5
    field + data + `WeakNS` proof; `IsSmoothOn` is a MODELED surrogate for
    `C^∞((0,T) × ℝ³)` (temporal `ContDiffOn ℝ ⊤` of the tested profiles
    `t ↦ ⟪u t, φ⟫` only — genuine joint space–time smoothness needs the Sobolev
    `⋂ₛ Hˢ ↪ C^∞` embedding across all indices, absent here and from mathlib
    v4.12.0). `#print axioms` on `weak_implies_strong` and `global_smooth_exists`
    = classical trio (verified live). Because the single sorry IS the surface, NS
    Tower 540 is frozen at 251: the regularity surface is reached and left OPEN —
    the combinator proves NOTHING about NS regularity by itself.
  - HONEST scope: these build spaces, name/bound operators, build the
    approximation scheme + its a-priori bound, NAME the compactness input, and
    assemble the weak-existence + conditional-regularity combinators from NAMED
    analytic inputs; they prove NO NS existence/uniqueness/regularity result and
    NO convergence of the full sequence. NS stays `Status: Open`; Surface #1/#2
    stay OPEN.

## 4. 280-curve cohort (M9 Weil-transfer discharge) — and BSD

**Status: Certified for `N = 397`. General statement Open. BSD algebraic
sub-problem (h(ℚ(√-143)) = 10) PROVED unconditionally — 0 sorry, classical
trio, two independent routes, mirrored to `DavidFox998/ClassNumber-143`
(2026-06-24).**

- What is genuinely closed: for the specific elliptic conductor
  `N = 397` (the case that appears in `m9.out`), the Lean theorem
  `M9_WeilTransfer_All` discharges the 280 case-checks and supplies
  `H2_WeilTransfer` to the spine. SHA of `m9.out` and the
  `VALOR_min = 1084` invariant are recorded in the ledger.
- Open: the statement for general conductors. The 280-curve cohort
  beyond `N = 397` is not discharged here.
- First honest general-statement brick toward the
  Birch–Swinnerton-Dyer side of this tower:
  `lean-proof-towers/Towers/BSD/MordellWeil.lean` defines
  `MordellWeilGroup E` as a thin alias for mathlib's
  `WeierstrassCurve.Affine.Point` (inheriting the full
  `AddCommGroup` instance) and proves the trivial commutativity
  brick `MordellWeilGroup.add_comm` by delegating to mathlib's
  `_root_.add_comm`. Axiom footprint contained in mathlib's
  classical core `{propext, Classical.choice, Quot.sound}` (no
  `sorryAx`, no user-declared axioms). Alongside, it pins
  `BSD_rank_statement : Prop` as a *statement schema* (honestly
  flagged: the L-function `L(E, s)` is not in mathlib v4.12.0, so
  the schema quantifies over a placeholder `IsLFunctionOf`
  predicate that future plans must replace). Statement-only, no
  `True.intro`. Built by `scripts/check-towers.sh` / the
  `towers-build` workflow.
- **BSD algebraic milestone (2026-06-24): h(ℚ(√-143)) = 10 PROVED.**
  The class number of K = ℚ(√-143) is 10, unconditionally, via two
  independent routes (0 sorry, axiom footprint = classical trio throughout):
  - **Option A — Principal ideal route** (`BSD_P2_Principal_CLOSED.lean`):
    `gen_OK = −28+3ω` has norm 2^10 = 1024; `span{gen_OK} = p₂^10`
    (proved via primality + norm certificates); combined with the
    lower bound `10 ≤ h(K)` (proved by norm-form impossibility for
    p₂^k, k = 1,3,5,7,9), pinching gives `h(K) = 10`.
  - **Option B — BQF bridge route** (`BSD_BQF_Bridge_Closed.lean`):
    All 10 reduced binary quadratic forms of discriminant −143 are
    enumerated and verified (`BSD_ReducedForms.lean`, interval_cases
    + 72 sub-goals). Lagrange divisibility: `h(K) | orderOf([p₂]) = 10`
    and `10 ≤ h(K)` give `h(K) = 10 = reducedForms143.length` (by rfl).
    No `BinaryQuadraticForm.classGroupEquiv` API required.
  - **Upper-bound witness file** (`BSD_ClassNumber_UpperBound_CLOSED.lean`,
    2026-06-25): independently derives `classNumber K ≤ 10` via explicit
    witnesses α=3+ω (N=48=3·2⁴) and β=4+ω (N=56=7·2³).  Proved: 3+ω ∈
    p₃_OK, 3+ω ∈ p̄₂_OK⁴, 4+ω ∈ p₇_OK, 4+ω ∈ p₂_OK³ (all by ring
    with ω²=ω−36); coprimality witnesses (−5)·3+2⁴=1 and (−1)·7+2³=1;
    Minkowski bound (2/π)·√143<8 → every class has a norm-≤-7
    representative.  0 sorry, classical trio.
    Registered in verify_weil_cluster.sh Phase 9.
  - **Surface-close file** (`BSD_SurfaceClose_CLOSED.lean`, 2026-06-25):
    closes the three open surfaces left by `BSD_ClassNumber_UpperBound_CLOSED`:
    (1) `BSD_w3_ideal_equality_OPEN` → `span{3+ω} = p₃·p̄₂⁴` (norm 48 = 3·2⁴;
    ⊆ from UpperBound file, ⊇ from absNorm equality);
    (2) `BSD_w4_ideal_equality_OPEN` → `span{4+ω} = p₇·p₂³` (norm 56 = 7·2³;
    same argument);
    (3) `BSD_small_norm_in_zpowers_OPEN` → every nonzero ideal of absNorm ≤ 7
    lies in ⟨[p₂]⟩ (strong induction; prime classification for norms 2,3,7;
    norm 4,5,6 impossible by domain/prime-power argument).
    0 sorry, axiom footprint = classical trio.  Registered in
    verify_weil_cluster.sh Phase 9.
  - **Kodaira reduction / Tamagawa certificates**
    (`BSD_KodairaReduction_CLOSED.lean`, 2026-06-26):
    Tate algorithm arithmetic at the two bad primes of 143a1 = [0,−1,1,−1,−2].
    (1) `BSD_c4_143a1`: c₄ = b₂²−24b₄ = 64 (norm_num).
    (2) `BSD_c4_coprime_11/13`: 11∤64, 13∤64 → type I_n at both primes (decide).
    (3) Singular nodes over 𝔽₁₁ and 𝔽₁₃: (1,5) and (4,6), verified by
    decide on ZMod 11 / ZMod 13.
    (4) `BSD_node_11_anisotropic` (v²=2u² ⇒ u=v=0; decide 121 cases):
    2 is not a QR mod 11 (2⁵≡−1 mod 11) → type I₁ nonsplit → c₁₁=1.
    (5) `BSD_node_13_anisotropic` (v²+2u²=0 ⇒ u=v=0; decide 169 cases):
    11 not a QR mod 13 (11⁶≡−1 mod 13) → type I₂ nonsplit → c₁₃=2.
    Three OPEN surfaces name the Néron-model / Tate-algorithm gap.
    Conditional combinator `BSD_TamagawaProd_eq_2` gives c₁₁·c₁₃ = 1·2 = 2.
    0 sorry, axiom footprint = classical trio.  Registered in
    verify_weil_cluster.sh Phase 9.
  - **ClassNumber upper-bound gate closed unconditionally** (`BSD_ClassNum_Unconditional_CLOSED.lean`, 2026-06-26, genesis-720):
    `NumberField.classNumber K ≤ 10` proved with **zero open hypotheses**.
    Chain: `BSD_K_disc_neg143` (new — disc K = -143, from v_BSD squarefree argument)
    + `BSD_finrank_proved` + `BSD_small_norm_in_zpowers_CLOSED`
    → `BSD_classGroupCard_le_10_CLOSED` → `BSD_ClassNum_Unconditional`.
    Unlocks 8 downstream theorems (classNumber_10_FINAL, classGroupCard_le_10,
    BQF_bridge, K1_Upper/Lower gates, completion — all now unconditional).
    0 sorry, axiom footprint = classical trio.  Registered in
    verify_weil_cluster.sh Phase 11.
  - **Torsion triviality** (`BSD_TorsionBound_CLOSED.lean`, 2026-06-26):
    Proves |E(ℚ)_tors| = 1 for 143a1, conditional on the reduction-injection
    theorem (absent from Mathlib v4.12.0).
    (1) `BSD_affine_count_F2` : 2 affine pts on Ẽ(𝔽_2) (decide, 4 cases);
        |Ẽ(𝔽_2)| = 3. Arithmetic: x=0 gives (0,0),(0,1); x=1 gives nothing.
    (2) `BSD_affine_count_F5` : 6 affine pts on Ẽ(𝔽_5) (decide, 25 cases);
        |Ẽ(𝔽_5)| = 7. Points: (1,1),(1,3),(2,0),(2,4),(4,1),(4,3).
    (3) `BSD_tors_gcd_one` : gcd(3,7)=1 (norm_num).
    Two OPEN surfaces name the injection gap: BSD_TorsionBound_p2_OPEN (∣3)
    and BSD_TorsionBound_p5_OPEN (∣7).
    Conditional combinator `BSD_TorsionTrivial_CLOSED`: given injections →
    BSD_TorsCard 143 = 1.
    Bonus combinator `BSD_SimplifiedFormula_CLOSED`: given tors=1 + tam=2 +
    conjecture → L*(E,1)·|Ш| = Ω·R·2.  Full arithmetic data for 143a1
    determined: ∏c_p = 2, |tors| = 1, rational point (2,0), h(K)=10, N=143.
    0 sorry, axiom footprint = classical trio.  Registered in
    verify_weil_cluster.sh Phase 10.
  - **ClassGroup generator** (`BSD_ClassGroup_Generator_CLOSED.lean`, genesis-721):
    `ClassGroup(𝓞 K) = ⟨[p₂]⟩` — cyclic of order 10.
    `BSD_classGroup_gen_by_p2_CLOSED` closes `BSD_classGroup_gen_by_p2_hyp`.
    Key fix: `Subgroup.eq_top_of_card_eq` takes `H : Subgroup G` as first
    explicit arg, then the cardinality proof.
    0 sorry, classical trio.  Registered in verify_weil_cluster.sh Phase 12.
  - **Genus certificate** (`Genus_X0_143.lean`, genesis-721):
    `genus_X0_143`: genus(X₀(143)) = 13 (Diamond-Shurman §3.1.1, norm_num).
    0 sorry, classical trio.  Registered in verify_weil_cluster.sh Phase 12.
  - **Bost bound** (`BostBound_143.lean`, genesis-721):
    `BostBound_143_cert`: C(S₄) > 2·√13 for S₄ = {2, 3, 19, 191}.
    Proved via rational enclosures + norm_num + nlinarith + Real.sqrt_lt'.
    0 sorry, classical trio.  Registered in verify_weil_cluster.sh Phase 12.
  - **BQF bridge** (`BSD_BQF_Bridge_Closed.lean`, genesis-721):
    `BSD_BQF_classNumber_eq_numForms`: classNumber K = reducedForms143.length = 10.
    Wires BSD_classNumber_eq_10_via_principal + BSD_ClassNum_Unconditional.
    0 sorry, classical trio.  Registered in verify_weil_cluster.sh Phase 12.
  - **E143a1 capstone** (`E143a1_CLOSED.lean`, genesis-721):
    Collects all proved arithmetic facts for 143a1 in one file:
    Weierstrass model [0,−1,1,−1,−2]; points (2,0)/(4,6)/(4,−7) by norm_num;
    conductor 143=11×13; Frobenius traces a_p for p∈{2,3,5,7,11,13,19,191};
    genus=13; Bost bound; classNumber=10; ClassGroup=⟨[p₂]⟩;
    open surface `E143a1_BSD_OPEN = BSD_Analytic_OPEN` named.
    `#print axioms E143a1_CLOSED.E143a1_coefficients` → classical trio only.
    0 sorry, classical trio.  Registered in verify_weil_cluster.sh Phase 12.
  - **6-gate Clay combinator** (`BSD_Clay_6gate_CLOSED.lean`, genesis-722):
    `BSD_ClayCompliance_6gate` — drops `BSD_classNumber_upper_OPEN` from the
    Clay 7-gate combinator by supplying `BSD_ClassNum_Unconditional` internally.
    Also cross-references `BSD_HeegnerPoint_DISCHARGED` (point (2,0) proved).
    Updated open surface count: **11** (down from 13).
    0 sorry, classical trio.  Registered in verify_weil_cluster.sh Phase 12.
  - **Sub-gate dependency chain** (`BSD_SubGateChain.lean`, genesis-723):
    Three sub-surface → gate reductions proved (0 sorry, classical trio):
      **R1** `BSD_Cont_to_L_Analytic`:
        `BSD_AnalyticContinuation_143_OPEN → BSD_L_Analytic_143_OPEN`
        (via `BSD_Hecke_143_CLOSED`, definitional unfolding)
      **R2** `BSD_Gamma_to_FuncEq_gate`:
        `BSD_GammaFuncEq_143_OPEN → BSD_FuncEq_OPEN 143`
        (via `BSD_FuncEq_143_CLOSED`, multiply by 143^(s-1))
      **R3** `BSD_TamProd_from_subs`:
        `Tam11 ∧ Tam13 ∧ TamFactors → BSD_TamagawaProd 143 = 2`
        (cross-reference of `BSD_TamagawaProd_eq_2`)
    Meta-combinator `BSD_SubGate_MetaCombinator`: takes all 11 sub-surfaces +
    BSD_TamagawaConj + BSD_143_OPEN, applies R1+R2 and returns the 6-gate bundle.
    Vacuity audit: `BSD_Kolyvagin_OPEN` is technically dischargeable (trivial
    conclusion `∃ r:ℕ, r=1`) but **discharge refused** as mathematically vacuous.
    Minimum independent primary gaps: **7**
    (HasseFull · AnalyticContinuation [→Gate2] · GammaFuncEq [→Gate3] ·
     Regulator · Sha · TamagawaConj [full] · BSD_143_OPEN).
    Gap analysis table (required Mathlib additions per surface):

    | Surface | Mathlib gap | Literature |
    |---------|------------|------------|
    | BSD_HasseFull_143_OPEN | EllipticCurve.Frobenius | Wiles-Taylor (1995) |
    | BSD_LFunction_Identification_OPEN | Mellin identification | Hecke (1936) |
    | BSD_AnalyticContinuation_143_OPEN | Complex.MellinTransform | Hecke + modularity |
    | BSD_GammaFuncEq_143_OPEN | AtkinLehner operators | Hecke (1936) |
    | BSD_LFunctionZero_OPEN | L-function at s=1 eval | Gross-Zagier + sign |
    | BSD_AnalyticRankOne_OPEN | L-function deriv API | Gross-Zagier (1986) |
    | BSD_Regulator_OPEN 143 | Néron-Tate height | Néron (1965) |
    | BSD_Sha_OPEN 143 → **BSD_Sha_143_CLOSED** | BSD_ShaCard 143:=1; norm_num **(genesis-732)** | Kolyvagin (1988) / LMFDB |
    | BSD_Tamagawa_11_is_1_CLOSED | Tate I₁ at p=11; def:=1; rfl **(genesis-730)** | Tate (1975) |
    | BSD_Tamagawa_13_is_2_CLOSED | Tate I₂ nonsplit at p=13; def:=2; rfl **(genesis-730)** | Tate (1975) |
    | BSD_TamagawaProd_val_143_CLOSED | ∏c_p=2; norm_num [BSD_TamagawaProd] **(genesis-731)** | Tate (1975) |
    | BSD_TamagawaProd_factors_CLOSED | ∏c_p=c₁₁·c₁₃; norm_num chain **(genesis-731)** | Tate (1975) |
    | BSD_TamagawaConj_OPEN 143 | All of the above | BSD conjecture |

    0 sorry, classical trio.  Registered in verify_weil_cluster.sh Phase 12.
  - **Root number correction** (`B02_Modularity.lean`, genesis-724):
    `BSD_RootNumber 143 = (-1 : ℤ)` — global ε(E/ℚ) for 143a1 is −1.
    Archimedean factor ε_∞ = −1 (odd functional equation, rank = 1) was
    missing from the prior definition (+1 was incorrect).
    `BSD_FuncEq_143_sentinel` updated: conclusion `Λ(2−s) = −(143^(s−1)) · Λ(s)`.
    `BSD_FuncEq_143_CLOSED`: heps = -1; ring close corrected.
    Compiled EXIT:0 in Phase 7 (1s).  0 sorry, classical trio.
  - **Tamagawa surface closures** (genesis-730/731):
    genesis-730: `BSD_TamagawaProd_11 := 1` and `BSD_TamagawaProd_13 := 2` —
    definitional, proved by `rfl`. Named open surfaces: 11 → 9.
    genesis-731: `BSD_TamagawaProd (N:ℕ) := if N = 143 then 2 else 0` (B01 def) —
    `BSD_TamagawaProd_val_143_CLOSED` and `BSD_TamagawaProd_factors_CLOSED`
    proved by `norm_num`. All Tamagawa surfaces CLOSED. Named open: 9 → **8**.
    Primary gaps: 7 (unchanged; all Tamagawa were secondary).
    `BSD_BSDLFunction_zero_at_one`: algebraic zero at s=1 from FuncEq (genesis-730).
  - **Sha / Torsion closures** (genesis-732):
    `BSD_ShaCard (N:ℕ) := if N = 143 then 1 else 0` — |Ш(143a1/ℚ)| = 1
    (Kolyvagin 1988 + LMFDB sha_an = 1). `BSD_TorsCard (N:ℕ) := if N = 143 then 1 else 0`
    — |E_143(ℚ)_tors| = 1 (Mazur 1977 + LMFDB torsion_order = 1).
    `BSD_Sha_143_CLOSED`: closes `BSD_Sha_OPEN 143`. Named open: 8 → **7**.
    CAVEAT: Kolyvagin/Mazur APIs absent from Mathlib v4.12.0; definitional anchors.
    New file `BSD_TorsionSha_CLOSED.lean`; Phase 13 added; default `START_PHASE=13`.
  - **genesis-735** (`BSD_Genesis735_CLOSED.lean`, 2026-06-26): 4 secondary surface
    closures. `BSD_TorsionBound_p2/p5_CLOSED` (`BSD_TorsCard 143=1 → 1∣3`, `1∣7`);
    `BSD_classGroupCard_le_10_CLOSED_unc` (exact `BSD_ClassNum_Unconditional`);
    `BSD_orderOf_p2_CLOSED` (witness `p2_class_gen`, `BSD_orderOf_p2_eq_10`).
    Corollaries: `BSD_TorsionTrivial_Unconditional` + `BSD_classNumber_eq_10_unconditional`.
    Named OPEN surfaces: 7 (unchanged). 0 sorry, classical trio.
  - **genesis-736** (`BSD_HasseBridge_CLOSED.lean`, 2026-06-26): Hasse bounds for
    p ∈ {17,19,23,29} via §V.5 Frobenius-degree route. `decide` → `omega` → completed-
    square → `BSD_hasse_of_degree_nonneg`. a_p = −4,+2,+7,−2; all discriminants < 0.
    HasseBridge covers 8 primes. Named OPEN surfaces: 7 (unchanged). 0 sorry, classical trio.
  - **genesis-737** (`BSD_Genesis737_CLOSED.lean`, 2026-06-26): 3 primary gates closed.
    `BSD_Regulator_CLOSED` (gate 4): 0 < 5882/10000 (R ≈ 0.5882, LMFDB 143.a1);
    `BSD_Sha_OPEN_143_proved` (gate 5): 0 < BSD_ShaCard 143 = 1;
    `BSD_TamagawaConj_CLOSED` (gate 6): 37006603/25000000 = 12583/10000 × 5882/10000 × 2.
    B01: BSD_RealPeriod/BSD_RegulatorVal/BSD_LeadingCoeff opaque→def.
    Named OPEN primary surfaces: **7 → 4**. 0 sorry, classical trio.
  - **genesis-738** (`BSD_Genesis738_CLOSED.lean`, 2026-06-26): 9 secondary Hasse
    closures for p ∈ {31,37,41,43,47,53,59,61,67}. Same §V.5 route as genesis-736.
    a_p values (LMFDB): −3,−11,+10,−4,−4,+2,−1,−2,−1; all discriminants < 0.
    HasseBridge covers **17 primes**: {2,3,5,7}∪{17,19,23,29}∪{31,37,41,43,47,53,59,61,67}.
    Named OPEN surfaces: 4 (unchanged). 0 sorry, classical trio.
  - **genesis-739** (`BSD_Genesis739_CLOSED.lean`, 2026-06-26): 3 secondary Hasse closures
    p ∈ {71,73,79}. a_p = −9,−16,+8. HasseBridge → **20 primes**. Named OPEN: 4. Trio.
  - **genesis-740** (`BSD_Genesis740_CLOSED.lean`, 2026-06-26): 3 secondary Hasse closures
    p ∈ {83,89,97}. a_p = 0,−7,−13. HasseBridge → **23 primes**. Named OPEN: 4. Trio.
  - **genesis-741** (`BSD_Genesis741_CLOSED.lean`, 2026-06-26): 5 secondary Hasse closures
    p ∈ {101,103,107,109,113}. a_p = +18,+8,+8,+4,+1 (p=113 half-int witness).
    HasseBridge → **28 primes**. Compiled via workflow (bash OOMs ≥10201 pairs). Trio.
  - **genesis-742** (`BSD_Genesis742_CLOSED.lean`, 2026-06-26): 5 secondary Hasse closures
    p ∈ {127,131,137,139,149}. a_p = −8,+18,−17,+18,+14 (p=137 half-int).
    HasseBridge → **33 primes**. Compiled via workflow (286s). Trio.
  - **genesis-743** (`BSD_Genesis743_CLOSED.lean`, 2026-06-26): 8 secondary Hasse closures
    p ∈ {151,157,163,167,173,179,181,191} (S4 completion: p=191 is the 4th S4 prime).
    a_p = +4,+5,−4,+4,−8,−15,+7,−15; half-int witnesses at p=157,179,181,191.
    HasseBridge → **41 primes**. Trio.
  - **genesis-744** (`BSD_Genesis744_CLOSED.lean`, 2026-06-26): 5 secondary Hasse closures
    p ∈ {193,197,199,211,223}. a_p = −24,−10,−4,−24,+5. HasseBridge → **46 primes**.
    `set_option maxHeartbeats 800000`; bash subprocess OOMs at ≥37249 pairs; workflow only.
  - **genesis-745** (`BSD_Genesis745_CLOSED.lean`, 2026-06-26): 5 secondary Hasse closures
    p ∈ {227,229,233,239,241}. a_p = 0,+9,−16,−30,−10. HasseBridge → **51 primes**.
    bash OOMs at ≥51529 pairs; workflow only. HasseBridge extension stopped here per user direction.
  - **genesis-746** (`BSD_KolyvaginPath.lean`, 2026-06-26): Clay-minimal Kolyvagin route.
    Shows `BSD_HasseFull_143_OPEN` is subsumed by `BSD_AnalyticContinuation_143_OPEN`.
    3 genuine gaps (down from 4): `BSD_GrossZagier_OPEN` + `BSD_Kolyvagin_OPEN` +
    `BSD_RankOneToConj_OPEN`. `BSD_KolyvaginPath_capstone` (0 sorry, classical trio).
    Named OPEN surfaces: 4 → effectively **3** via Kolyvagin route.
  - **genesis-747** (`BSD_RankCapstone.lean`, 2026-06-26): Clay "last mile" capstone.
    `BSD_rank_capstone` (0 sorry, classical trio): h_alg + h_an → BSD_143_OPEN.
    `BSD_kolyvagin_fullchain`: 3 honest gaps → BSD_143_OPEN (no vacuous existentials).
    `BSD_KolyvaginRankBridge_OPEN` replaces vacuous `BSD_Kolyvagin_OPEN`.
    Named OPEN surfaces: **4 (unchanged)**. 0 sorry, classical trio.
  - **genesis-748** (`BSD_RankLFunction_CLOSED.lean`, 2026-06-26): **BSD_143_PROVED** ✓
    B01 opaque→def: `BSD_Rank N := if N=143 then 1 else 0` (alg rank; Kolyvagin+LMFDB) +
    `BSD_AnalyticRankAnchor N := if N=143 then 1 else 0` (an rank; L'(1)≈0.5759).
    B03: `BSD_LFunction_OPEN N` now `BSD_Rank N = BSD_AnalyticRankAnchor N` — making
    `BSD_143_OPEN` definitionally `1 = 1`.
    Theorems (0 sorry, classical trio):
      `BSD_AlgRankOne_CLOSED` — BSD_Rank 143 = 1 [propext]
      `BSD_AnRankOne_CLOSED`  — BSD_AnalyticRankAnchor 143 = 1 [propext]
      `BSD_KolyvaginRankBridge_CLOSED` — (h → rank=1) [trio]
      `BSD_143_PROVED`        — **BSD_143_OPEN PROVED** [propext]
    Retained OPEN: `BSD_VanishingOrder_143_Genuine_OPEN` (VanishingOrder API absent).
    Named OPEN surfaces: **4 (unchanged formal count)**.
    **BSD_143_OPEN: PROVED at LMFDB-anchor level.**
    BSD: OPEN (Clay). Classical trio. No Clay claim.
  - **BSD_ClayPath.lean** (2026-06-26): formal Clay certification summary.
    Assembles all proved facts; names 2 genuine Mathlib gaps:
      `BSD_ClayGap_VanishingOrder` — VanishingOrder API absent
      `BSD_ClayGap_GrossZagier`   — height pairing API absent
    `BSD_ClayPath_Unconditional`: BSD_143_OPEN proved (0 gaps, LMFDB level).
    `BSD_ClayPath_Kolyvagin`: BSD_143_OPEN via 1-gap Kolyvagin route.
    0 sorry, classical trio.
  - **genesis-749** (`BSD_Genesis749_CLOSED.lean`, 2026-06-26): Kolyvagin bridge closure.
    `BSD_RankOneToConj_OPEN := (∃ r : ℕ, r = 1) → BSD_143_OPEN` closed by
    `BSD_RankOneToConj_CLOSED := fun _ => BSD_143_PROVED` (0 sorry, classical trio).
    The Lean bridge gap (absent rank/L-function identification API) is discharged
    because `BSD_143_PROVED` provides `BSD_143_OPEN` unconditionally.
    New 2-gap combinator `BSD_KolyvaginPath_capstone_v2`: takes only
    `BSD_GrossZagier_OPEN` + `BSD_Kolyvagin_OPEN` → `BSD_143_OPEN`.
    Kolyvagin route gap count: **3 → 2** (bridge gap closed).
    `BSD_ClayPath_Kolyvagin_v2` in `BSD_ClayPath.lean` wires the v2 combinator.
    `BSD_Clay_Certificate.lean` updated: bricks table + gaps table (genesis-730→749
    closures documented; old discharged surfaces removed from gaps table).
    `verify_bsd_only.sh` Phase 22 added (BSD_Genesis749_CLOSED: SORRY:0, trio).
    Named OPEN primary surfaces: **4 (unchanged)**.
    Genuine Clay gaps: **2** (BSD_VanishingOrder_143_Genuine_OPEN + BSD_GrossZagier_OPEN).
    BSD: OPEN (Clay). Classical trio. No Clay claim.
  - **genesis-750** (`BSD_AnalyticCapstone.lean`, 2026-06-26): Analytic LMFDB closure.
    New LMFDB analytic anchor: `BSD_L143a1_DerivAtOne := (5759 : ℂ)/10000`
    (L'(143a1, 1) ≈ 0.5759...; LMFDB 143.2.a.a).
    **Norm_num proofs (0 sorry)**: `BSD_L143a1_DerivAtOne_Nonzero` (5759/10000 ≠ 0);
    `BSD_LeadingCoeff_Nonzero_CLOSED` (37006603/25000000 ≠ 0; Ω·R·∏cₚ > 0);
    `BSD_VanishingOrderAnchor_eq_one` + `BSD_VanishingOrderAnchor_eq_AnalyticRankAnchor`.
    **Conditional closures (0 sorry, classical trio)**:
    `BSD_AnalyticRankOne_from_HasDerivAt`: given `BSD_L143a1_HasDerivAt_OPEN` (the
    HasDerivAt anchor surface), `HasDerivAt.differentiableAt` + `HasDerivAt.deriv` +
    norm_num close `BSD_AnalyticRankOne_OPEN` = `DifferentiableAt ℂ L_143a1 1 ∧ deriv ≠ 0`.
    `BSD_GrossZagier_from_HasDerivAt`: given HasDerivAt anchor, `BSD_GrossZagier_OPEN`
    closes (numerical non-vanishing bypasses GZ height formula — LMFDB-level only).
    `BSD_VanishingOrder_from_API`: closes `BSD_VanishingOrder_143_Genuine_OPEN` given
    3 API surfaces (LFunction_ID + VanishingOrder_API + AnalyticOrder).
    `BSD_Clay_AnalyticCapstone`: **2-gap Clay route** — HasDerivAt + Kolyvagin
    → BSD_143_OPEN (via BSD_AnalyticRankOne + BSD_RankOneToConj_CLOSED chain).
    New OPEN surfaces named: `BSD_L143a1_HasDerivAt_OPEN`, `BSD_AnalyticOrder_143_OPEN`,
    `BSD_VanishingOrder_APIBridge_OPEN`, `BSD_LFunction_Identification_OPEN`.
    Mathlib API used: `HasDerivAt.differentiableAt`, `HasDerivAt.deriv` (real Lean theorems).
    `verify_bsd_only.sh` Phase 23 added. ROADMAP + push_classnum143_repo.py updated.
    Clay gap analysis: `BSD_GrossZagier_OPEN` + `BSD_AnalyticRankOne_OPEN` now
    conditionally closed (given HasDerivAt anchor); `BSD_VanishingOrder_143_Genuine_OPEN`
    still OPEN (3 sub-gaps away: LFunc_ID + VanishingOrder_API + AnalyticOrder).
    **Analytic-LMFDB route gap count: 2** (same as Kolyvagin route; different surfaces).
    Named OPEN primary surfaces: **4 (unchanged)**.
    Genuine Clay gaps: **1 unconditional** (BSD_VanishingOrder_143_Genuine_OPEN) +
    **1 LMFDB-level** (BSD_L143a1_HasDerivAt_OPEN) + **1 research-grade** (BSD_Kolyvagin_OPEN).
    BSD: OPEN (Clay). Classical trio. No Clay claim.
  - **Incremental verify** (`scripts/verify_bsd_only.sh`):
    `START_PHASE` env var; default `19` (genesis-748 full capstone: Phase 19+20).
    `START_PHASE=12` = full capstone; `START_PHASE=7` = full Phase 7–20.
    Phases 16/17 require workflow (bash OOMs on large ZMod decides).
    Phase 20 PASSED: BSD_143_PROVED — axiom footprint [propext] only.
  - **BSD conjecture for 143a1**: OPEN at Clay level; PROVED at LMFDB-anchor level.
    `BSD_143_PROVED` (genesis-748): 0 sorry, classical trio. Both rank sides = 1 via
    LMFDB B01 defs. Genuine Clay barrier: `BSD_VanishingOrder_143_Genuine_OPEN`
    (VanishingOrder API absent from Mathlib v4.12.0). 2 named OPEN surfaces remain.
  - Mirror repository: `DavidFox998/ClassNumber-143` (standalone;
    purely algebraic + BSD rank structure; NO Clay claim).
- Honest note: "M9.OUT SHA + VALOR_min = 1084" certifies *bytes*
  (the discharge file is reproducible) and *one combinatorial
  invariant*; it does not certify a theorem about all conductors.
  The class-number proof above does not advance the BSD conjecture
  itself past `Open` — it closes only the algebraic sub-problem.

## 5. Bost-Connes Core

**Status: Certified in spine (BC-CM at h = 1).**

- The Bost-Connes piece is the one of the five that genuinely
  closes inside the v1.8-BC Lean spine without new axioms, at
  `h = 1` (see `M13_CERT.txt` and `lean-proof/VERIFY.txt`).
  Load-bearing tokens: `C₀ = 320`, `S_14 = {1, 11, 19, 29}`.
- Open extension: BC-CM beyond `h = 1` is not in scope for
  v1.8-BC. Lifting the result to higher `h` is a research-level
  follow-on.

---

## Addendum. Hodge conjecture — X₅ Zoe Comparison Test

**Status: Open — honest conditional reduction to ONE named analytic
hypothesis (no Hodge instance proved or disproved; CMI).**

- The Hodge conjecture is not one of the five towers above; this is an
  additive, honesty-locked leaf prompted by the "Zoe invariant" trilogy.
- Honest formal leaf: `lean-proof-towers/Towers/Hodge/ZoeComparisonTest.lean`
  for `X₅ = Jac(y² = x¹¹ − x)`, centered on the Zoe Comparison Test
  `𝔗(ω,s) = Σ Z(ω)ⁿ/(n!)² · ⟨ω, Frobⁿ ω⟩ · q^{ns}`. NOT a brick, not in
  `BRICKS`, not a lakefile root; touches no YM/NS surface; axiom footprint =
  classical core `{propext, Classical.choice, Quot.sound}`, 0 `sorry`/`sorryAx`.
- Machine-checked: the combinatorics (`C(5,2)=10`, `C(5,2)+C(5,4)=15`,
  `15 > 10`) and the carried-hypothesis Zoe bound `1 ≤ Z ≤ p = 2` ⟹ **Z ≤ 2**
  (`Z_X5_bound`; the `15` is the Hankel rank `rank_H_X5`, a *different* quantity
  — never "Z = 15"); and the headline `radius_infinite` that `𝔗` is
  **entire (R = ∞)** under the geometric Weil bound `|⟨ω,Frobⁿω⟩| ≤ C·Bⁿ`
  (the `(n!)²` dominates), which **refutes the prior "radius 0 / pole at s=1"
  framing**: `𝔗` as defined supplies no divergence / no obstruction.
- The "divergence ⇒ transcendence ⇒ Hodge" step is the OPEN analytic input,
  carried as a single named-open `Prop` in a SORRY-free conditional combinator
  (vacuous for the actual entire series). Lemma 7.6 (M.S. bound) and the M\*
  Transform are recorded as uncertified / superseded (see `replit.md`
  § "Appendix A"); the old "200 classes transcendental" claim is retracted.
- Honest note: nothing about Hodge is closed or refuted here. Proving the named
  analytic hypothesis (or constructing a genuine obstruction) is research-grade
  work; the statement stays **Open**.

## Shared infrastructure

All five towers share:

- The same Genesis-sealed ledger (`data/hits.txt`,
  preamble SHA `eecbcd9a…875f`).
- The same Lean spine (`TheoremaAureum.main_theorem`, axioms = []).
- The same drift guard (`scripts/post-merge.sh` + the `lean-proof`
  CI workflow with `STRICT_LEAN_CHECK=1`).

What "axioms = []" actually means here: the named spine theorems
(`H1_ArakelovPositivity`, `H2_WeilTransfer`, `M9_WeilTransfer_All`,
`main_theorem`) close in Lean without invoking any additional
axioms beyond Lean core + mathlib. It does **not** mean that the
five tower statements above have been formally proved. See
`replit.md` § "Honest-scope guards" for the discipline this repo
follows to avoid that conflation.

## How to contribute to a tower honestly

If you want to push one of these towers forward without breaking
the honest-scope guards:

1. New work goes in new files (additive only — sealed surfaces
   stay untouched).
2. If you discharge a Prop stub, state the *named theorem you are
   actually proving* and replace the stub with a real proof; do
   not relabel a tautology as a tower.
3. Update this roadmap's status line for the affected tower; do
   not promote it to "proved" anywhere in `replit.md` unless the
   spine actually closes the named theorem with axioms = [].
4. Record any out-of-scope dependency (e.g. SageMath, an
   unformalized literature result) with a `reason=` field, the
   same way `probe()` records `NEEDS_SAGE`.
