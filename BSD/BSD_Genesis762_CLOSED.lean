import Towers.BSD.BSD_Genesis761_CLOSED
import Towers.BSD.BSD_Genesis745_CLOSED

set_option maxRecDepth 10000
set_option maxHeartbeats 400000

/-!
================================================================
Towers / BSD / BSD_Genesis762_CLOSED  (genesis-762)

**Path B: Discriminant bridge for 51 proved primes + 1D-slice experiment**

### Two contributions

**A.  Discriminant bridge (51 primes, Clay gate level)**

  The HasseBridge chain (genesis-734 through genesis-745) proved
  `BSD_FrobeniusDegreeNonneg_OPEN p` for 51 primes p ≤ 241 (all good reduction).
  That is the §V.5 form: ∀ r:ℝ, r²−(a_p p:ℝ)·r+(p:ℝ) ≥ 0.

  Genesis-760 proved the equivalence:
    BSD_FrobeniusDegreeNonneg_OPEN p  ↔  BSD_HasseBound_Discriminant_OPEN at p.

  This file wires all 51 DegreeNonneg proofs to the discriminant form
  (a_p p)²≤4p at the Clay gate level via the helper
  `BSD_disc_from_degree_nonneg`.

  Result: BSD_HasseBound_Discriminant_OPEN is PROVED for 51 primes ≤ 241.
  Corrects genesis-761 tier analysis (Tier A = 51, not 4).

**B.  1D-slice experiment for p = 83**

  Background (genesis-739/740): direct `decide` over ZMod 83 × ZMod 83 (6889
  pairs) OOMs in a bash subprocess; genesis-740 solved this by compiling via
  the Lean workflow (same `by decide`, different host process).

  The 1D-slice methodology uses `E143_fiber p x` (already defined in
  BSD_LFunction.lean): for a FIXED x ∈ ZMod p, count y satisfying the curve
  equation.  Each fiber is over ZMod p (p elements, not p² pairs).

  This file proves:
    1. `E143_Finset_card_eq_sum_fibers` — general decomposition theorem:
       card(E143_Finset p) = ∑ x, card(E143_fiber p x).    (0 sorry)
    2. Five concrete fiber counts for p=83 by `decide`:
       x=0: 0,  x=2: 2,  x=15: 1 (tangent),  x=50: 2,  x=82: 0.
       Each decide is over ZMod 83 (83 elements; recursion depth O(p) not O(p²)).

  Why the 1D-slice avoids the bash-subprocess OOM:
    - Bash subprocess has a limited kernel stack / memory budget.
    - Direct 2D decide allocates O(p²) kernel frames; p=83 → 6889 → overflow.
    - Each 1D fiber decide allocates O(p)=O(83) frames — well within budget.
    - Full 83-fiber proof + sum would recover (E143_Finset 83).card = 83
      independently of genesis-740; roadmapped for genesis-763.

  p=83 fiber distribution (Python-verified):
    41 rows with count=0, 41 rows with count=2, 1 row (x=15) with count=1.
    Sum = 0·41+2·41+1·1 = 83 = p − a₈₃.  (a₈₃=0 ✓)

### Coverage after genesis-762
  HasseBound_Discriminant_OPEN (Clay gate level): 51 primes ≤ 241.
  Remaining Clay gaps: 2 (unchanged).
    Gate 1 (BSD_HasseBound_Discriminant_OPEN): proved for 51/∞ good primes.
    Gate 2 (BSD_LFunctionIsLinFunc_OPEN): OPEN.

SORRY: 0.  Axiom footprint: classical trio {propext, Classical.choice, Quot.sound}.
================================================================
-/

namespace Towers.BSD

-- ============================================================
-- §0.  Fact instances for all 51 proved primes
--      (genesis-734..745 declare them private; redeclared here)
-- ============================================================

private instance i762_p2 : Fact (2 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p3 : Fact (3 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p5 : Fact (5 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p7 : Fact (7 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p17 : Fact (17 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p19 : Fact (19 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p23 : Fact (23 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p29 : Fact (29 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p31 : Fact (31 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p37 : Fact (37 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p41 : Fact (41 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p43 : Fact (43 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p47 : Fact (47 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p53 : Fact (53 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p59 : Fact (59 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p61 : Fact (61 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p67 : Fact (67 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p71 : Fact (71 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p73 : Fact (73 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p79 : Fact (79 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p83 : Fact (83 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p89 : Fact (89 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p97 : Fact (97 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p101 : Fact (101 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p103 : Fact (103 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p107 : Fact (107 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p109 : Fact (109 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p113 : Fact (113 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p127 : Fact (127 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p131 : Fact (131 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p137 : Fact (137 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p139 : Fact (139 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p149 : Fact (149 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p151 : Fact (151 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p157 : Fact (157 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p163 : Fact (163 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p167 : Fact (167 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p173 : Fact (173 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p179 : Fact (179 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p181 : Fact (181 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p191 : Fact (191 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p193 : Fact (193 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p197 : Fact (197 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p199 : Fact (199 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p211 : Fact (211 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p223 : Fact (223 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p227 : Fact (227 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p229 : Fact (229 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p233 : Fact (233 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p239 : Fact (239 : ℕ).Prime := ⟨by norm_num⟩
private instance i762_p241 : Fact (241 : ℕ).Prime := ⟨by norm_num⟩

-- ============================================================
-- §1.  Helper: FrobeniusDegreeNonneg → discriminant form
-- ============================================================

/-- Bridge: if the quadratic r²−a_p·r+p is nonneg for all r, then a_p²≤4p.
    Proved by specialising at r = a_p/2 and applying nlinarith. -/
private lemma BSD_disc_from_degree_nonneg {p : ℕ}
    (h : BSD_FrobeniusDegreeNonneg_OPEN p) : (a_p p : ℝ) ^ 2 ≤ 4 * (p : ℝ) := by
  have hspec := h ((a_p p : ℝ) / 2)
  nlinarith [hspec]

-- ============================================================
-- §2.  Discriminant bounds for all 51 proved primes
--      Each closes by one application of BSD_disc_from_degree_nonneg.
-- ============================================================

-- genesis-734 ({2,3,5,7})
theorem BSD_HasseBound_Disc_p2 : (a_p 2 : ℝ) ^ 2 ≤ 4 * (2 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p2

theorem BSD_HasseBound_Disc_p3 : (a_p 3 : ℝ) ^ 2 ≤ 4 * (3 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p3

theorem BSD_HasseBound_Disc_p5 : (a_p 5 : ℝ) ^ 2 ≤ 4 * (5 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p5

theorem BSD_HasseBound_Disc_p7 : (a_p 7 : ℝ) ^ 2 ≤ 4 * (7 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p7

-- genesis-736 ({17,19,23,29})
theorem BSD_HasseBound_Disc_p17 : (a_p 17 : ℝ) ^ 2 ≤ 4 * (17 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p17

theorem BSD_HasseBound_Disc_p19 : (a_p 19 : ℝ) ^ 2 ≤ 4 * (19 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p19

theorem BSD_HasseBound_Disc_p23 : (a_p 23 : ℝ) ^ 2 ≤ 4 * (23 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p23

theorem BSD_HasseBound_Disc_p29 : (a_p 29 : ℝ) ^ 2 ≤ 4 * (29 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p29

-- genesis-738 ({31..67})
theorem BSD_HasseBound_Disc_p31 : (a_p 31 : ℝ) ^ 2 ≤ 4 * (31 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p31

theorem BSD_HasseBound_Disc_p37 : (a_p 37 : ℝ) ^ 2 ≤ 4 * (37 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p37

theorem BSD_HasseBound_Disc_p41 : (a_p 41 : ℝ) ^ 2 ≤ 4 * (41 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p41

theorem BSD_HasseBound_Disc_p43 : (a_p 43 : ℝ) ^ 2 ≤ 4 * (43 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p43

theorem BSD_HasseBound_Disc_p47 : (a_p 47 : ℝ) ^ 2 ≤ 4 * (47 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p47

theorem BSD_HasseBound_Disc_p53 : (a_p 53 : ℝ) ^ 2 ≤ 4 * (53 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p53

theorem BSD_HasseBound_Disc_p59 : (a_p 59 : ℝ) ^ 2 ≤ 4 * (59 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p59

theorem BSD_HasseBound_Disc_p61 : (a_p 61 : ℝ) ^ 2 ≤ 4 * (61 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p61

theorem BSD_HasseBound_Disc_p67 : (a_p 67 : ℝ) ^ 2 ≤ 4 * (67 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p67

-- genesis-739 ({71,73,79})
theorem BSD_HasseBound_Disc_p71 : (a_p 71 : ℝ) ^ 2 ≤ 4 * (71 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p71

theorem BSD_HasseBound_Disc_p73 : (a_p 73 : ℝ) ^ 2 ≤ 4 * (73 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p73

theorem BSD_HasseBound_Disc_p79 : (a_p 79 : ℝ) ^ 2 ≤ 4 * (79 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p79

-- genesis-740 ({83,89,97})
theorem BSD_HasseBound_Disc_p83 : (a_p 83 : ℝ) ^ 2 ≤ 4 * (83 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p83

theorem BSD_HasseBound_Disc_p89 : (a_p 89 : ℝ) ^ 2 ≤ 4 * (89 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p89

theorem BSD_HasseBound_Disc_p97 : (a_p 97 : ℝ) ^ 2 ≤ 4 * (97 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p97

-- genesis-741 ({101..113})
theorem BSD_HasseBound_Disc_p101 : (a_p 101 : ℝ) ^ 2 ≤ 4 * (101 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p101

theorem BSD_HasseBound_Disc_p103 : (a_p 103 : ℝ) ^ 2 ≤ 4 * (103 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p103

theorem BSD_HasseBound_Disc_p107 : (a_p 107 : ℝ) ^ 2 ≤ 4 * (107 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p107

theorem BSD_HasseBound_Disc_p109 : (a_p 109 : ℝ) ^ 2 ≤ 4 * (109 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p109

theorem BSD_HasseBound_Disc_p113 : (a_p 113 : ℝ) ^ 2 ≤ 4 * (113 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p113

-- genesis-742 ({127..149})
theorem BSD_HasseBound_Disc_p127 : (a_p 127 : ℝ) ^ 2 ≤ 4 * (127 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p127

theorem BSD_HasseBound_Disc_p131 : (a_p 131 : ℝ) ^ 2 ≤ 4 * (131 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p131

theorem BSD_HasseBound_Disc_p137 : (a_p 137 : ℝ) ^ 2 ≤ 4 * (137 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p137

theorem BSD_HasseBound_Disc_p139 : (a_p 139 : ℝ) ^ 2 ≤ 4 * (139 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p139

theorem BSD_HasseBound_Disc_p149 : (a_p 149 : ℝ) ^ 2 ≤ 4 * (149 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p149

-- genesis-743 ({151..191})
theorem BSD_HasseBound_Disc_p151 : (a_p 151 : ℝ) ^ 2 ≤ 4 * (151 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p151

theorem BSD_HasseBound_Disc_p157 : (a_p 157 : ℝ) ^ 2 ≤ 4 * (157 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p157

theorem BSD_HasseBound_Disc_p163 : (a_p 163 : ℝ) ^ 2 ≤ 4 * (163 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p163

theorem BSD_HasseBound_Disc_p167 : (a_p 167 : ℝ) ^ 2 ≤ 4 * (167 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p167

theorem BSD_HasseBound_Disc_p173 : (a_p 173 : ℝ) ^ 2 ≤ 4 * (173 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p173

theorem BSD_HasseBound_Disc_p179 : (a_p 179 : ℝ) ^ 2 ≤ 4 * (179 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p179

theorem BSD_HasseBound_Disc_p181 : (a_p 181 : ℝ) ^ 2 ≤ 4 * (181 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p181

theorem BSD_HasseBound_Disc_p191 : (a_p 191 : ℝ) ^ 2 ≤ 4 * (191 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p191

-- genesis-744 ({193..223})
theorem BSD_HasseBound_Disc_p193 : (a_p 193 : ℝ) ^ 2 ≤ 4 * (193 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p193

theorem BSD_HasseBound_Disc_p197 : (a_p 197 : ℝ) ^ 2 ≤ 4 * (197 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p197

theorem BSD_HasseBound_Disc_p199 : (a_p 199 : ℝ) ^ 2 ≤ 4 * (199 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p199

theorem BSD_HasseBound_Disc_p211 : (a_p 211 : ℝ) ^ 2 ≤ 4 * (211 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p211

theorem BSD_HasseBound_Disc_p223 : (a_p 223 : ℝ) ^ 2 ≤ 4 * (223 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p223

-- genesis-745 ({227..241})
theorem BSD_HasseBound_Disc_p227 : (a_p 227 : ℝ) ^ 2 ≤ 4 * (227 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p227

theorem BSD_HasseBound_Disc_p229 : (a_p 229 : ℝ) ^ 2 ≤ 4 * (229 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p229

theorem BSD_HasseBound_Disc_p233 : (a_p 233 : ℝ) ^ 2 ≤ 4 * (233 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p233

theorem BSD_HasseBound_Disc_p239 : (a_p 239 : ℝ) ^ 2 ≤ 4 * (239 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p239

theorem BSD_HasseBound_Disc_p241 : (a_p 241 : ℝ) ^ 2 ≤ 4 * (241 : ℝ) :=
  BSD_disc_from_degree_nonneg BSD_DegreeNonneg_p241

-- ============================================================
-- §3.  Clay gate evidence sentinel (51 primes)
-- ============================================================

/-- Sentinel: BSD_HasseBound_Discriminant_OPEN is proved at the Clay gate level
    for all 51 good primes ≤ 241.  States the smallest (p=2) and largest (p=241)
    as a compact record; see BSD_HasseBound_Disc_p{N} for individual proofs. -/
theorem BSD_HasseBound_Discriminant_51prime_CLOSED :
    (a_p 2 : ℝ) ^ 2 ≤ 4 * 2 ∧ (a_p 241 : ℝ) ^ 2 ≤ 4 * 241 :=
  ⟨BSD_HasseBound_Disc_p2, BSD_HasseBound_Disc_p241⟩

/-- Tier-A correction (cf. genesis-761 tier analysis):
    BSD_HasseBound_Discriminant_OPEN is Tier A (proved, 0 sorry, classical trio)
    for 51 primes, not just 4.  Tier B (p in 251..997 outside the HasseBridge)
    and Tier C (p > 997) remain open. -/
theorem BSD_HasseBound_Discriminant_TierA_51 :
    ∀ p ∈ ({2, 3, 5, 7, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67,
            71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137,
            139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199,
            211, 223, 227, 229, 233, 239, 241} : Finset ℕ),
    ∃ (_h : Nat.Prime p) (_hnd : ¬(p ∣ 143)), (a_p p : ℝ) ^ 2 ≤ 4 * (p : ℝ) := by
  simp only [Finset.mem_insert, Finset.mem_singleton]
  intro p hp
  fin_cases hp <;>
    exact ⟨by norm_num, by norm_num, by
      first
      | exact BSD_HasseBound_Disc_p2   | exact BSD_HasseBound_Disc_p3
      | exact BSD_HasseBound_Disc_p5   | exact BSD_HasseBound_Disc_p7
      | exact BSD_HasseBound_Disc_p17  | exact BSD_HasseBound_Disc_p19
      | exact BSD_HasseBound_Disc_p23  | exact BSD_HasseBound_Disc_p29
      | exact BSD_HasseBound_Disc_p31  | exact BSD_HasseBound_Disc_p37
      | exact BSD_HasseBound_Disc_p41  | exact BSD_HasseBound_Disc_p43
      | exact BSD_HasseBound_Disc_p47  | exact BSD_HasseBound_Disc_p53
      | exact BSD_HasseBound_Disc_p59  | exact BSD_HasseBound_Disc_p61
      | exact BSD_HasseBound_Disc_p67  | exact BSD_HasseBound_Disc_p71
      | exact BSD_HasseBound_Disc_p73  | exact BSD_HasseBound_Disc_p79
      | exact BSD_HasseBound_Disc_p83  | exact BSD_HasseBound_Disc_p89
      | exact BSD_HasseBound_Disc_p97  | exact BSD_HasseBound_Disc_p101
      | exact BSD_HasseBound_Disc_p103 | exact BSD_HasseBound_Disc_p107
      | exact BSD_HasseBound_Disc_p109 | exact BSD_HasseBound_Disc_p113
      | exact BSD_HasseBound_Disc_p127 | exact BSD_HasseBound_Disc_p131
      | exact BSD_HasseBound_Disc_p137 | exact BSD_HasseBound_Disc_p139
      | exact BSD_HasseBound_Disc_p149 | exact BSD_HasseBound_Disc_p151
      | exact BSD_HasseBound_Disc_p157 | exact BSD_HasseBound_Disc_p163
      | exact BSD_HasseBound_Disc_p167 | exact BSD_HasseBound_Disc_p173
      | exact BSD_HasseBound_Disc_p179 | exact BSD_HasseBound_Disc_p181
      | exact BSD_HasseBound_Disc_p191 | exact BSD_HasseBound_Disc_p193
      | exact BSD_HasseBound_Disc_p197 | exact BSD_HasseBound_Disc_p199
      | exact BSD_HasseBound_Disc_p211 | exact BSD_HasseBound_Disc_p223
      | exact BSD_HasseBound_Disc_p227 | exact BSD_HasseBound_Disc_p229
      | exact BSD_HasseBound_Disc_p233 | exact BSD_HasseBound_Disc_p239
      | exact BSD_HasseBound_Disc_p241⟩

-- ============================================================
-- §4.  1D-slice experiment: E143_fiber decomposition for p = 83
-- ============================================================
-- BSD_LFunction.lean already defines E143_fiber:
--   def E143_fiber (p : N) [Fact p.Prime] (x : ZMod p) : Finset (ZMod p) :=
--     Finset.univ.filter fun y => E143_point p x y
-- BSD_LFunction.lean's card_E143_le uses this decomposition internally.
-- Here we extract the general card-equality form and demonstrate
-- the per-fiber decide for p = 83.

/-- **Decomposition theorem**: the total affine point count equals the
    sum of per-x fiber counts.  Proof follows BSD_LFunction.lean's
    `card_E143_le` (which uses the same biUnion partition internally). -/
theorem E143_Finset_card_eq_sum_fibers (p : ℕ) [Fact p.Prime] :
    (E143_Finset p).card = ∑ x : ZMod p, (E143_fiber p x).card := by
  classical
  -- Fiber-equality lemma: filter by x-coord equals image of fiber
  have fiber_eq : ∀ x : ZMod p,
      (E143_Finset p).filter (fun xy => xy.1 = x) =
      (E143_fiber p x).image (fun y => (x, y)) := by
    intro x; ext ⟨a, b⟩
    simp only [Finset.mem_filter, Finset.mem_image, E143_Finset, E143_fiber,
               Finset.mem_univ, true_and, Prod.mk.injEq]
    change (E143_point p a b ∧ a = x) ↔ ∃ y, E143_point p x y ∧ x = a ∧ y = b
    constructor
    · rintro ⟨hP, rfl⟩; exact ⟨b, hP, rfl, rfl⟩
    · rintro ⟨y, hP, rfl, rfl⟩; exact ⟨hP, rfl⟩
  -- Step 1: total card = sum of filter-by-x cards (biUnion partition)
  have hpart : (E143_Finset p).card =
      ∑ x : ZMod p, ((E143_Finset p).filter (fun xy => xy.1 = x)).card := by
    rw [← Finset.card_biUnion]
    · congr 1; ext xy
      simp [Finset.mem_biUnion, Finset.mem_filter]
    · intro x _ y _ hne
      apply Finset.disjoint_filter.mpr
      intro z _ ⟨h1, h2⟩
      exact hne (h1.symm.trans h2)
  -- Step 2: each filter-by-x card = fiber card (image of injective function)
  rw [hpart]
  congr 1; ext x
  rw [fiber_eq x]
  exact Finset.card_image_of_injective _ (fun a b h => (Prod.mk.inj h).2)

-- ============================================================
-- §4a.  Concrete fiber counts for p = 83 (by decide, O(83) each)
-- ============================================================
-- p = 83: E143_fiber 83 x is a subset of ZMod 83 (83 elements).
-- Each decide evaluates 83 membership tests — no kernel blow-up.
-- Compare: BSD_E143_card_p83 (genesis-740) uses a single decide over
-- ZMod 83 × ZMod 83 (6889 pairs) — blows up bash, fine in workflow.
--
-- Distribution for p=83 (Python-verified):
--   x in {0,1,3,7,10,11,12,13,19,20,21,22,23,24,25,27,33,37,40,41,42,
--           44,45,49,52,54,55,56,57,58,59,60,63,64,67,70,72,73,75,77,82}
--         → count = 0   (41 rows)
--   x in {2,4,5,6,8,9,14,16,17,18,26,28,29,30,31,32,34,35,36,38,39,43,
--           46,47,48,50,51,53,61,62,65,66,68,69,71,74,76,78,79,80,81}
--         → count = 2   (41 rows)
--   x = 15 → count = 1   (unique tangent / flex point)
-- Sum = 0*41 + 2*41 + 1*1 = 83 = p - a_p(83) = 83 - 0 ✓

/-- Fiber at x=0 (count 0 — no solutions). -/
theorem BSD_E143_fiber_p83_x0  : (E143_fiber 83  (0 : ZMod 83)).card = 0 := by decide
/-- Fiber at x=2 (count 2 — two y solutions). -/
theorem BSD_E143_fiber_p83_x2  : (E143_fiber 83  (2 : ZMod 83)).card = 2 := by decide
/-- Fiber at x=15 (count 1 — tangent/flex point; unique row with odd count). -/
theorem BSD_E143_fiber_p83_x15 : (E143_fiber 83 (15 : ZMod 83)).card = 1 := by decide
/-- Fiber at x=50 (count 2 — two y solutions). -/
theorem BSD_E143_fiber_p83_x50 : (E143_fiber 83 (50 : ZMod 83)).card = 2 := by decide
/-- Fiber at x=82 (count 0 — no solutions). -/
theorem BSD_E143_fiber_p83_x82 : (E143_fiber 83 (82 : ZMod 83)).card = 0 := by decide

-- ============================================================
-- §5.  Named open surfaces / gap sentinels
-- ============================================================

/-- OPEN: Hasse bound for primes 251 ≤ p ≤ 997 (Tier B — not yet in HasseBridge).
    Proof route: extend the HasseBridge chain to cover all 168 LMFDB primes,
    OR close the compatibility bridge BSD_HasseCompatibility_OPEN for those primes.
    Mathlib wall: none (decidable for each p; workflow can compile). -/
def BSD_HasseSmallPrime_Tier_B_OPEN : Prop :=
  ∀ p ∈ Finset.Icc 251 997, Nat.Prime p → ¬(p ∣ 143) →
    (a_p p : ℝ) ^ 2 ≤ 4 * (p : ℝ)

/-- OPEN: Hasse bound for primes p > 997 (Tier C).
    Requires Mathlib EllipticCurve.Frobenius + Isogeny.degree (Silverman AEC V.2). -/
def BSD_HasseLargePrime_Tier_C_OPEN : Prop :=
  ∀ p : ℕ, Nat.Prime p → p > 997 → ¬(p ∣ 143) →
    (a_p p : ℝ) ^ 2 ≤ 4 * (p : ℝ)

-- ============================================================
-- §6.  Clay gate combinator (genesis-762)
-- ============================================================

/-- genesis-762 combinator: BSD_143_OPEN follows from two gaps.
    Same structure as genesis-760; adds 51-prime discriminant evidence.
    Primary gaps unchanged: HasseBound_Discriminant + LFunctionIsLinFunc.  -/
theorem BSD_Genesis762_Combinator
    (hd : BSD_HasseBound_Discriminant_OPEN)
    (hl : BSD_LFunctionIsLinFunc_OPEN) :
    BSD_143_OPEN :=
  BSD_Genesis760_Combinator hd hl

end Towers.BSD
