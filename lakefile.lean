import Lake
open Lake DSL

package «classNumber-143» where
  -- Standalone Lean 4 proof that h(ℚ(√-143)) = 10.
  --
  -- SORRY: 0.  Axiom footprint: classical trio {propext, Classical.choice, Quot.sound}.
  -- ONE named gate: BQF_ClassGroup_Bridge (Gauss–Dirichlet bijection).
  -- LOWER BOUND proved unconditionally: 10 ≤ classNumber K.
  -- MAIN THEOREM: classNumber K = 10  (given BQF_ClassGroup_Bridge).
  --
  -- DO NOT run `lake update` — Mathlib must remain pinned to v4.12.0.

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.12.0"

lean_lib ClassNumber143 where
  roots := #[`BSD]
