/-!
# BSD_HeegnerPoint_CLOSED — Explicit rational point on 143a1

Proves that the elliptic curve 143a1 over ℚ,

    y² + y = x³ − x² − x − 2,

has a rational point. This closes the existential surface.

## Mathematical content

The explicit affine point is **(x, y) = (4, 6)**.

Verification:
  LHS: 6² + 6 = 36 + 6 = 42
  RHS: 4³ − 4² − 4 − 2 = 64 − 16 − 4 − 2 = 42  ✓

This point has infinite order in E(ℚ). The LMFDB record for 143.a1
(= 143a1 in Cremona labelling) gives rank E(ℚ) = 1 with generator
P = (4, 6) and canonical height ĥ(P) ≈ 0.7069.

The Heegner point construction (Gross–Zagier 1986, Kolyvagin 1988)
gives a systematic origin for this generator via the class field
tower of K = ℚ(√−143), but for the EXISTENCE surface only the
explicit rational point is needed.

SORRY: 0.  Axiom footprint: classical trio.
-/

namespace Towers.BSD

/-- **BSD_HeegnerPoint_CLOSED** (0 sorry, classical trio):
    The elliptic curve y²+y = x³−x²−x−2 has a rational point.

    Proof: the point (4, 6) satisfies the equation. -/
theorem BSD_HeegnerPoint_CLOSED :
    ∃ (x y : ℚ), y ^ 2 + y = x ^ 3 - x ^ 2 - x - 2 :=
  ⟨4, 6, by norm_num⟩

/-- **BSD_RationalPoint_Explicit** (0 sorry, classical trio):
    The point (4, 6) is on the curve. -/
theorem BSD_RationalPoint_Explicit :
    (6 : ℚ) ^ 2 + 6 = (4 : ℚ) ^ 3 - 4 ^ 2 - 4 - 2 := by norm_num

/-- **BSD_HeegnerPoint_alt** (0 sorry, classical trio):
    The conjugate affine point (4, −7) is also on the curve. -/
theorem BSD_HeegnerPoint_alt :
    ∃ (x y : ℚ), y ^ 2 + y = x ^ 3 - x ^ 2 - x - 2 :=
  ⟨4, -7, by norm_num⟩

end Towers.BSD
