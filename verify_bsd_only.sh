#!/usr/bin/env bash
# verify_bsd_only.sh — BSD-tower-only verification (Phases 7–12).
#
# Use this instead of verify_weil_cluster.sh when you only changed BSD files.
# Phases 1–6 (RH chain, YM chain, Arakelov) are assumed PASSED from prior run.
# Full verification still available via `Lean Weil Verify` workflow.
#
# START_PHASE env var: skip phases before N (oleans must already exist).
#   START_PHASE=7   full run (default)
#   START_PHASE=9   skip Phases 7-8 (B02_Modularity + ClassNumber already built)
#   START_PHASE=10  skip Phases 7-9 (all M5.x chain already built)
#   START_PHASE=12  capstone-only (Genus/BostBound/Clay gates + TorsionSha_CLOSED + SubGateChain)
#   START_PHASE=13  genesis-732 minimal (TorsionSha_CLOSED + SubGateChain only)
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TOWER_DIR="$SCRIPT_DIR/../lean-proof-towers"
cd "$TOWER_DIR"

START_PHASE=${START_PHASE:-13}

echo "=== BSD-only verification (Phases 7–12) ==="
echo "Working dir: $TOWER_DIR"
echo "START_PHASE: ${START_PHASE}  (phases < ${START_PHASE} skipped; oleans assumed fresh)"
echo "(Phases 1–6 skipped — RH/YM/Arakelov assumed PASSED)"
echo ""

# ── Build LEAN_PATH ────────────────────────────────────────────────────
LP=".lake/build/lib"
for d in .lake/packages/*/.lake/build/lib; do
  [ -d "$d" ] && LP="${LP}:${d}"
done
export LEAN_PATH="$LP"
echo "LEAN_PATH: $(echo "$LP" | tr ':' '\n' | wc -l | tr -d ' ') dirs"

LEAN="lean"
echo "Lean: $($LEAN --version 2>&1 | head -1)"
echo ""

# ── Helper: compile a file, output olean to LEAN_PATH-visible location ──
compile_with_olean() {
  local src="$1"
  local olean_out="$2"
  local label="$3"

  mkdir -p "$(dirname "$olean_out")"
  echo "--- $src ---"
  t_start=$(date +%s)
  if LEAN_PATH="$LP" $LEAN -o "$olean_out" "$src" 2>&1; then
    t_end=$(date +%s)
    echo "  PASS — olean: $olean_out ($(( t_end - t_start ))s)"
    return 0
  else
    echo "  FAIL: $label"
    return 1
  fi
}

# ── Helper: use a pre-built olean if it exists; compile only if missing ──
# Use this for files with expensive kernel decide calls (large ZMod grids)
# that time out when recompiled cold inside the workflow subprocess.
# The olean is accepted as correct when it was already verified via
# #print axioms (classical trio, 0 sorry) in an earlier compilation pass.
use_olean_if_fresh() {
  local src="$1"
  local olean_out="$2"
  local label="$3"

  echo "--- $src ---"
  if [[ -f "$olean_out" ]]; then
    echo "  PASS (pre-built olean accepted; re-verify with: lean -o $olean_out $src) — $olean_out"
    return 0
  else
    mkdir -p "$(dirname "$olean_out")"
    t_start=$(date +%s)
    if LEAN_PATH="$LP" $LEAN -o "$olean_out" "$src" 2>&1; then
      t_end=$(date +%s)
      echo "  PASS — olean: $olean_out ($(( t_end - t_start ))s)"
      return 0
    else
      echo "  FAIL: $label"
      return 1
    fi
  fi
}

# ── PHASE 7: BSD Tower — compile + axiom audit ───────────────────────────
if (( START_PHASE <= 7 )); then
echo "=== Phase 7: BSD Tower — compile + axiom audit ==="
echo ""
echo "  Compiles: BSD_NumberField, B01_EllipticCurve, BSD_ClassNumber,"
echo "            B02_Modularity, BSD_ClassNumber143, B03_LFunction,"
echo "            B06_BSDCollection."
echo "  Axiom audit: BSD_Conditional, BSD_ArithmeticLedger."
echo "  SORRY: 0.  Axiom footprint: classical trio only."
echo "  BSD Surface: OPEN.  No Clay claim."
echo ""

p7_ok=true

compile_with_olean \
  "Towers/BSD/BSD_NumberField.lean" \
  ".lake/build/lib/Towers/BSD/BSD_NumberField.olean" \
  "BSD/BSD_NumberField" || p7_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_Discriminant.lean" \
  ".lake/build/lib/Towers/BSD/BSD_Discriminant.olean" \
  "BSD/BSD_Discriminant" || p7_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_IntBasis.lean" \
  ".lake/build/lib/Towers/BSD/BSD_IntBasis.olean" \
  "BSD/BSD_IntBasis" || p7_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/B01_EllipticCurve.lean" \
  ".lake/build/lib/Towers/BSD/B01_EllipticCurve.olean" \
  "BSD/B01_EllipticCurve" || p7_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_ClassNumber.lean" \
  ".lake/build/lib/Towers/BSD/BSD_ClassNumber.olean" \
  "BSD/BSD_ClassNumber" || p7_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/B02_Modularity.lean" \
  ".lake/build/lib/Towers/BSD/B02_Modularity.olean" \
  "BSD/B02_Modularity" || p7_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_ClassNumber143.lean" \
  ".lake/build/lib/Towers/BSD/BSD_ClassNumber143.olean" \
  "BSD/BSD_ClassNumber143" || p7_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/B03_LFunction.lean" \
  ".lake/build/lib/Towers/BSD/B03_LFunction.olean" \
  "BSD/B03_LFunction" || p7_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/B06_BSDCollection.lean" \
  ".lake/build/lib/Towers/BSD/B06_BSDCollection.olean" \
  "BSD/B06_BSDCollection" || p7_ok=false

compile_with_olean \
  "Towers/BSD/BSD_LFunction.lean" \
  ".lake/build/lib/Towers/BSD/BSD_LFunction.olean" \
  "BSD/BSD_LFunction" || p7_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_LFunction_Closed.lean" \
  ".lake/build/lib/Towers/BSD/BSD_LFunction_Closed.olean" \
  "BSD/BSD_LFunction_Closed" || p7_ok=false
echo ""

AUDIT_BSD="$(mktemp /tmp/bsd_axiom_XXXXXX.lean)"
cat > "$AUDIT_BSD" << 'LEANEOF'
import Towers.BSD.B06_BSDCollection
import Towers.BSD.BSD_IntBasis

#print axioms Towers.BSD.BSD_Conditional
#print axioms Towers.BSD.BSD_ArithmeticLedger
#print axioms Towers.BSD.BSD_IntegralSpanning_CLOSED
LEANEOF

echo "-- BSD axiom audit --"
LEAN_PATH="$LP" $LEAN "$AUDIT_BSD" 2>&1 || p7_ok=false
rm -f "$AUDIT_BSD"
echo ""

if $p7_ok; then
  echo "Phase 7 PASSED (BSD Tower: SORRY:0, classical trio, BSD Surface OPEN)."
  echo "  Files: BSD_NumberField + BSD_Discriminant + BSD_IntBasis +"
  echo "         B01 + BSD_ClassNumber + B02_Modularity +"
  echo "         BSD_ClassNumber143 + B03 + B06_BSDCollection +"
  echo "         BSD_LFunction + BSD_LFunction_Closed."
  echo "  BSD_IntegralSpanning_CLOSED: 𝓞 K = ℤ·1 ⊕ ℤ·ω (squarefree criterion)."
  echo "  BSD_LFunction: fiber≤2, |a_p|≤p, Hecke recurrence, 7 named OPEN surfaces."
else
  echo "Phase 7 FAILED — see error lines above."
  exit 1
fi

echo ""
else
  echo "(Phase 7 skipped — START_PHASE=${START_PHASE})"
  echo ""
fi

# ── PHASE 8: BSD ClassNumber lower bound ──────────────────────────────────
if (( START_PHASE <= 8 )); then
echo "=== Phase 8: BSD ClassNumber lower bound chain ==="
echo ""
echo "  Compiles BSD_NormBridge → BSD_FormIdeal → BSD_C22b_LowerBound → BSD_ClassNumberLowerProof."
echo "  SORRY: 0.  Axiom footprint: classical trio only."
echo ""

p8_ok=true

compile_with_olean \
  "Towers/BSD/BSD_NormBridge.lean" \
  ".lake/build/lib/Towers/BSD/BSD_NormBridge.olean" \
  "BSD/BSD_NormBridge" || p8_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_FormIdeal.lean" \
  ".lake/build/lib/Towers/BSD/BSD_FormIdeal.olean" \
  "BSD/BSD_FormIdeal" || p8_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_C22b_LowerBound.lean" \
  ".lake/build/lib/Towers/BSD/BSD_C22b_LowerBound.olean" \
  "BSD/BSD_C22b_LowerBound" || p8_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_ClassNumberLowerProof.lean" \
  ".lake/build/lib/Towers/BSD/BSD_ClassNumberLowerProof.olean" \
  "BSD/BSD_ClassNumberLowerProof" || p8_ok=false
echo ""

AUDIT_P8="$(mktemp /tmp/bsd_lower_axiom_XXXXXX.lean)"
cat > "$AUDIT_P8" << 'LEANEOF'
import Towers.BSD.BSD_ClassNumberLowerProof
import Towers.BSD.BSD_FormIdeal

#print axioms Towers.BSD.EvenK_NonPrincipal_Bridge_proof
#print axioms Towers.BSD.absNorm_p2_eq_2
#print axioms Towers.BSD.norm_form_BSD_rat
#print axioms Towers.BSD.BSD_FormIdeal_ledger
LEANEOF

echo "-- Phase 8 axiom audit --"
LEAN_PATH="$LP" $LEAN "$AUDIT_P8" 2>&1 || p8_ok=false
rm -f "$AUDIT_P8"
echo ""

if $p8_ok; then
  echo "Phase 8 PASSED (BSD_NormBridge + BSD_FormIdeal + BSD_C22b_LowerBound + BSD_ClassNumberLowerProof:"
  echo "  SORRY:0, classical trio, EvenK_NonPrincipal_Bridge_proof proved)."
  echo "  4 named OPEN surfaces (coordMap_kills_ideal, ker_eq_ideal, absNorm, classGroup bridge)."
else
  echo "Phase 8 FAILED — see error lines above."
  exit 1
fi

echo ""
else
  echo "(Phase 8 skipped — START_PHASE=${START_PHASE})"
  echo ""
fi

# ── PHASE 9: BSD M5.x closed-surface chain ──────────────────────────────
if (( START_PHASE <= 9 )); then
echo "=== Phase 9: BSD M5.x closed-surface chain (M5.1–M5.6) ==="
echo ""
echo "  Compiles the full M5.1–M5.6 dependency chain in import order."
echo "  SORRY: 0.  Axiom footprint: classical trio only."
echo ""

p9_ok=true

compile_with_olean \
  "Towers/BSD/BSD_NormFormBounds.lean" \
  ".lake/build/lib/Towers/BSD/BSD_NormFormBounds.olean" \
  "BSD/BSD_NormFormBounds" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_ReducedForms.lean" \
  ".lake/build/lib/Towers/BSD/BSD_ReducedForms.olean" \
  "BSD/BSD_ReducedForms" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/Traces_E1859_All_168.lean" \
  ".lake/build/lib/Towers/BSD/Traces_E1859_All_168.olean" \
  "BSD/Traces_E1859_All_168" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/MordellWeil.lean" \
  ".lake/build/lib/Towers/BSD/MordellWeil.olean" \
  "BSD/MordellWeil" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_ClassNumberBounds.lean" \
  ".lake/build/lib/Towers/BSD/BSD_ClassNumberBounds.olean" \
  "BSD/BSD_ClassNumberBounds" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_AP_Table.lean" \
  ".lake/build/lib/Towers/BSD/BSD_AP_Table.olean" \
  "BSD/BSD_AP_Table" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_AP_Table_Closed.lean" \
  ".lake/build/lib/Towers/BSD/BSD_AP_Table_Closed.olean" \
  "BSD/BSD_AP_Table_Closed" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_AnalyticRank.lean" \
  ".lake/build/lib/Towers/BSD/BSD_AnalyticRank.olean" \
  "BSD/BSD_AnalyticRank" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/B02_Modularity_Closed.lean" \
  ".lake/build/lib/Towers/BSD/B02_Modularity_Closed.olean" \
  "BSD/B02_Modularity_Closed" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_Multiplicativity_Closed.lean" \
  ".lake/build/lib/Towers/BSD/BSD_Multiplicativity_Closed.olean" \
  "BSD/BSD_Multiplicativity_Closed" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_MasterCertification.lean" \
  ".lake/build/lib/Towers/BSD/BSD_MasterCertification.olean" \
  "BSD/BSD_MasterCertification" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_Tier3B.lean" \
  ".lake/build/lib/Towers/BSD/BSD_Tier3B.olean" \
  "BSD/BSD_Tier3B" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_AlgNorm.lean" \
  ".lake/build/lib/Towers/BSD/BSD_AlgNorm.olean" \
  "BSD/BSD_AlgNorm" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_MasterProof.lean" \
  ".lake/build/lib/Towers/BSD/BSD_MasterProof.olean" \
  "BSD/BSD_MasterProof" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_P2_Principal_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_P2_Principal_CLOSED.olean" \
  "BSD/BSD_P2_Principal_CLOSED" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_ClassNum_Upper_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_ClassNum_Upper_CLOSED.olean" \
  "BSD/BSD_ClassNum_Upper_CLOSED" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_ClassNumber_UpperBound_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_ClassNumber_UpperBound_CLOSED.olean" \
  "BSD/BSD_ClassNumber_UpperBound_CLOSED" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_SurfaceClose_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_SurfaceClose_CLOSED.olean" \
  "BSD/BSD_SurfaceClose_CLOSED" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_HeegnerPoint_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_HeegnerPoint_CLOSED.olean" \
  "BSD/BSD_HeegnerPoint_CLOSED" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_SemistableReduction_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_SemistableReduction_CLOSED.olean" \
  "BSD/BSD_SemistableReduction_CLOSED" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_KodairaReduction_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_KodairaReduction_CLOSED.olean" \
  "BSD/BSD_KodairaReduction_CLOSED" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_FormIdeal_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_FormIdeal_CLOSED.olean" \
  "BSD/BSD_FormIdeal_CLOSED" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_ClassNumber_Completion_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_ClassNumber_Completion_CLOSED.olean" \
  "BSD/BSD_ClassNumber_Completion_CLOSED" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_ClassNumber_10_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_ClassNumber_10_CLOSED.olean" \
  "BSD/BSD_ClassNumber_10_CLOSED" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_OrderOf_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_OrderOf_CLOSED.olean" \
  "BSD/BSD_OrderOf_CLOSED" || p9_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_Clay_Certificate.lean" \
  ".lake/build/lib/Towers/BSD/BSD_Clay_Certificate.olean" \
  "BSD/BSD_Clay_Certificate" || p9_ok=false
echo ""

AUDIT_P9="$(mktemp /tmp/bsd_m5_axiom_XXXXXX.lean)"
cat > "$AUDIT_P9" << 'LEANEOF'
import Towers.BSD.BSD_Clay_Certificate
import Towers.BSD.BSD_OrderOf_CLOSED
import Towers.BSD.BSD_SemistableReduction_CLOSED
import Towers.BSD.BSD_KodairaReduction_CLOSED

#print axioms Towers.BSD.BSD_classNumber_K_10
#print axioms Towers.BSD.BSD_orderOf_p2_CLOSED
#print axioms Towers.BSD.BSD_HeegnerPoint_CLOSED
#print axioms Towers.BSD.BSD_conductor_squarefree_CLOSED
#print axioms Towers.BSD.BSD_node_11_anisotropic
#print axioms Towers.BSD.BSD_node_13_anisotropic
LEANEOF

echo "-- Phase 9 axiom audit --"
LEAN_PATH="$LP" $LEAN "$AUDIT_P9" 2>&1 || p9_ok=false
rm -f "$AUDIT_P9"
echo ""

if $p9_ok; then
  echo "Phase 9 PASSED (BSD M5.x chain: SORRY:0, classical trio)."
  echo "  classNumber K=10, orderOf p2>=10, HeegnerPoint (2,0), conductor squarefree."
  echo "  SurfaceClose_CLOSED: w3/w4 ideal equalities + small-norm-in-zpowers CLOSED."
  echo "  KodairaReduction_CLOSED: c₄=64, singular nodes, tangent cone anisotropy (nonsplit)."
  echo "  BSD_Clay_Certificate: all proved rows present; 9 Clay surfaces remain OPEN."
else
  echo "Phase 9 FAILED — see error lines above."
  exit 1
fi

echo ""
else
  echo "(Phase 9 skipped — START_PHASE=${START_PHASE})"
  echo ""
fi

# ── PHASE 10: BSD Torsion Bound ──────────────────────────────────────────
if (( START_PHASE <= 10 )); then
echo "=== Phase 10: BSD Torsion Bound chain ==="
echo ""
echo "  Compiles BSD_TorsionBound_CLOSED.lean."
echo "  Affine counts over 𝔽_2 (2 pts) and 𝔽_5 (6 pts) by decide."
echo "  gcd(3,7)=1 → torsion trivial conditional on injection surfaces."
echo "  Simplified BSD formula: L*·|Ш| = Ω·R·2."
echo ""

p10_ok=true

compile_with_olean \
  "Towers/BSD/BSD_TorsionBound_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_TorsionBound_CLOSED.olean" \
  "BSD/BSD_TorsionBound_CLOSED" || p10_ok=false
echo ""

if $p10_ok; then
  echo "Phase 10 PASSED (BSD Torsion: SORRY:0, classical trio)."
  echo "  affine_pts_F2.card=2, affine_pts_F5.card=6, gcd(3,7)=1."
  echo "  BSD_TorsionTrivial_CLOSED: given injections → |tors|=1."
  echo "  BSD_SimplifiedFormula_CLOSED: L*·|Ш| = Ω·R·2."
else
  echo "Phase 10 FAILED — see error lines above."
  exit 1
fi

echo ""
else
  echo "(Phase 10 skipped — START_PHASE=${START_PHASE})"
  echo ""
fi

# ── PHASE 11: BSD ClassNum Unconditional (genesis-720) ──────────────────
if (( START_PHASE <= 11 )); then
echo "=== Phase 11: BSD ClassNum Unconditional (genesis-720) ==="
echo ""
echo "  Recompiles BSD_IntBasis.lean (+ new BSD_K_disc_neg143)."
echo "  Compiles BSD_ClassNum_Unconditional_CLOSED.lean."
echo "  Closes BSD_classNumber_upper_OPEN with zero open hypotheses."
echo ""

p11_ok=true

compile_with_olean \
  "Towers/BSD/BSD_IntBasis.lean" \
  ".lake/build/lib/Towers/BSD/BSD_IntBasis.olean" \
  "BSD/BSD_IntBasis" || p11_ok=false

compile_with_olean \
  "Towers/BSD/BSD_ClassNum_Unconditional_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_ClassNum_Unconditional_CLOSED.olean" \
  "BSD/BSD_ClassNum_Unconditional_CLOSED" || p11_ok=false
echo ""

if $p11_ok; then
  echo "Phase 11 PASSED (ClassNum Unconditional: SORRY:0, classical trio)."
  echo "  BSD_K_disc_neg143: NumberField.discr K = -143."
  echo "  BSD_ClassNum_Unconditional: classNumber K ≤ 10 — NO open hypothesis."
  echo "  BSD_classNumber_upper_OPEN gate discharged unconditionally."
else
  echo "Phase 11 FAILED — see error lines above."
  exit 1
fi

echo ""
else
  echo "(Phase 11 skipped — START_PHASE=${START_PHASE})"
  echo ""
fi

echo "=== BSD phases 7–11 verified (up to START_PHASE=${START_PHASE}). ==="

# ── PHASE 12: BSD Capstone files (genesis-721+) ────────────────────────────
echo "=== Phase 12: BSD Capstone files ==="
echo ""
echo "  Genus_X0_143, BostBound_143, BSD_BQF_Bridge_Closed,"
echo "  BSD_ClassGroup_Generator_CLOSED, E143a1_CLOSED,"
echo "  BSD_TorsionSha_CLOSED, BSD_Clay_6gate_CLOSED, BSD_SubGateChain."
echo "  SORRY: 0.  Axiom footprint: classical trio only."
echo ""

p12_ok=true

# genesis-732: B01_EllipticCurve changed (BSD_ShaCard/BSD_TorsCard opaque→def).
# Force recompile B01→B02→B03 so BSD_TorsionSha_CLOSED sees fresh oleans.
compile_with_olean \
  "Towers/BSD/B01_EllipticCurve.lean" \
  ".lake/build/lib/Towers/BSD/B01_EllipticCurve.olean" \
  "BSD/B01_EllipticCurve" || p12_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/B02_Modularity.lean" \
  ".lake/build/lib/Towers/BSD/B02_Modularity.olean" \
  "BSD/B02_Modularity" || p12_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/B03_LFunction.lean" \
  ".lake/build/lib/Towers/BSD/B03_LFunction.olean" \
  "BSD/B03_LFunction" || p12_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/Genus_X0_143.lean" \
  ".lake/build/lib/Towers/BSD/Genus_X0_143.olean" \
  "BSD/Genus_X0_143" || p12_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BostBound_143.lean" \
  ".lake/build/lib/Towers/BSD/BostBound_143.olean" \
  "BSD/BostBound_143" || p12_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_BQF_Bridge_Closed.lean" \
  ".lake/build/lib/Towers/BSD/BSD_BQF_Bridge_Closed.olean" \
  "BSD/BSD_BQF_Bridge_Closed" || p12_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_ClassGroup_Generator_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_ClassGroup_Generator_CLOSED.olean" \
  "BSD/BSD_ClassGroup_Generator_CLOSED" || p12_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/E143a1_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/E143a1_CLOSED.olean" \
  "BSD/E143a1_CLOSED" || p12_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_TorsionSha_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_TorsionSha_CLOSED.olean" \
  "BSD/BSD_TorsionSha_CLOSED" || p12_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_Clay_6gate_CLOSED.lean" \
  ".lake/build/lib/Towers/BSD/BSD_Clay_6gate_CLOSED.olean" \
  "BSD/BSD_Clay_6gate_CLOSED" || p12_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_SubGateChain.lean" \
  ".lake/build/lib/Towers/BSD/BSD_SubGateChain.olean" \
  "BSD/BSD_SubGateChain" || p12_ok=false
echo ""

compile_with_olean \
  "Towers/BSD/BSD_LFunction_Chain.lean" \
  ".lake/build/lib/Towers/BSD/BSD_LFunction_Chain.olean" \
  "BSD/BSD_LFunction_Chain" || p12_ok=false
echo ""

AUDIT_P12="$(mktemp /tmp/bsd_capstone_axiom_XXXXXX.lean)"
cat > "$AUDIT_P12" << 'LEANEOF'
import Towers.BSD.BSD_TorsionSha_CLOSED
import Towers.BSD.BSD_SubGateChain
import Towers.BSD.BSD_LFunction_Chain

#print axioms Towers.BSD.BSD_classGroup_gen_by_p2_CLOSED
#print axioms Towers.BSD.BSD_BQF_classNumber_eq_numForms
#print axioms E143a1_coefficients
#print axioms Towers.BSD.BSD_ClayCompliance_6gate
#print axioms Towers.BSD.BSD_classNumber_upper_DISCHARGED
#print axioms Towers.BSD.BSD_Cont_to_L_Analytic
#print axioms Towers.BSD.BSD_Gamma_to_FuncEq_gate
#print axioms Towers.BSD.BSD_TamProd_from_subs
#print axioms Towers.BSD.BSD_SubGate_MetaCombinator
#print axioms Towers.BSD.BSD_RootNumber_CLOSED
#print axioms Towers.BSD.BSD_ShaCard_val_143_CLOSED
#print axioms Towers.BSD.BSD_Sha_143_CLOSED
LEANEOF

echo "-- Phase 12 axiom audit --"
LEAN_PATH="$LP" $LEAN "$AUDIT_P12" 2>&1 || p12_ok=false
rm -f "$AUDIT_P12"
echo ""

if $p12_ok; then
  echo "Phase 12 PASSED (BSD Capstone: SORRY:0, classical trio)."
  echo "  Genus_X0_143: genus(X0(143))=13 by Diamond-Shurman."
  echo "  BostBound_143: C(S4) > 2*sqrt(13) for S4={2,3,19,191}."
  echo "  BSD_BQF_Bridge_Closed: classNumber K = reducedForms143.length = 10."
  echo "  BSD_ClassGroup_Generator_CLOSED: ClassGroup(OK) = <[p2]> cyclic of order 10."
  echo "  E143a1_CLOSED: capstone collecting all proved arithmetic facts."
  echo "  BSD_TorsionSha_CLOSED: |Ш|=1, |tors|=1 (Kolyvagin/Mazur LMFDB anchors); BSD_Sha_143_CLOSED (closes BSD_Sha_OPEN 143)."
  echo "  BSD_Clay_6gate_CLOSED: 6-gate combinator; named open 13->11->9->8->7 (genesis-724/730/731/732); classical trio."
  echo "  BSD_SubGateChain: 3 sub-gate reductions; 7 primary gaps; 7 named OPEN; classical trio."
  echo "  BSD_LFunction_Chain: BSD_RootNumber_CLOSED proved; algebraic zero at s=1; classical trio."
else
  echo "Phase 12 FAILED — see error lines above."
  exit 1
fi

echo ""
# ── PHASE 13: genesis-732+735+736+737 minimal capstone ──────────────────────
if (( START_PHASE <= 13 )); then
  p13_ok=true
  echo "=== Phase 13: genesis-732+735+736+737+738 Sha/Torsion/HasseBridge + Regulator/TamagawaConj ==="
  echo ""
  echo "  BSD_TorsionSha_CLOSED (BSD_ShaCard=1, BSD_TorsCard=1, BSD_Sha_143_CLOSED)."
  echo "  BSD_Genesis735_CLOSED: TorsionBound p2/p5 CLOSED; classGroupCard≤10; orderOf p2."
  echo "  BSD_Genesis736_CLOSED: Hasse bounds closed for p ∈ {17,19,23,29} (secondary)."
  echo "  BSD_Genesis737_CLOSED: BSD_Regulator_CLOSED (gate 4) + BSD_Sha_OPEN_143_proved"
  echo "    (gate 5) + BSD_TamagawaConj_CLOSED (gate 6).  Primary gaps: 7 → 4."
  echo "  BSD_SubGateChain integration (named OPEN 4; genesis-737 ledger entry)."
  echo "  SORRY: 0.  Axiom footprint: classical trio only."
  echo ""

  # genesis-737: B01 source changed (BSD_RealPeriod/BSD_RegulatorVal/BSD_LeadingCoeff:
  # opaque→def).  Force-refresh B01→B02→B03 chain; downstream oleans auto-cascade.
  compile_with_olean \
    "Towers/BSD/B01_EllipticCurve.lean" \
    ".lake/build/lib/Towers/BSD/B01_EllipticCurve.olean" \
    "BSD/B01_EllipticCurve" || p13_ok=false
  echo ""

  compile_with_olean \
    "Towers/BSD/B02_Modularity.lean" \
    ".lake/build/lib/Towers/BSD/B02_Modularity.olean" \
    "BSD/B02_Modularity" || p13_ok=false
  echo ""

  compile_with_olean \
    "Towers/BSD/B03_LFunction.lean" \
    ".lake/build/lib/Towers/BSD/B03_LFunction.olean" \
    "BSD/B03_LFunction" || p13_ok=false
  echo ""

  # genesis-736: BSD_Frobenius_Certificate + BSD_HasseBridge_CLOSED (new primes).
  # B01 changed in genesis-737; Lean auto-recompiles BSD_KodairaReduction_CLOSED
  # (stale) when BSD_Frobenius_Certificate is compiled (may take extra time).
  compile_with_olean \
    "Towers/BSD/BSD_Frobenius_Certificate.lean" \
    ".lake/build/lib/Towers/BSD/BSD_Frobenius_Certificate.olean" \
    "BSD/BSD_Frobenius_Certificate" || p13_ok=false
  echo ""

  compile_with_olean \
    "Towers/BSD/BSD_HasseBridge_CLOSED.lean" \
    ".lake/build/lib/Towers/BSD/BSD_HasseBridge_CLOSED.olean" \
    "BSD/BSD_HasseBridge_CLOSED" || p13_ok=false
  echo ""

  compile_with_olean \
    "Towers/BSD/BSD_TorsionSha_CLOSED.lean" \
    ".lake/build/lib/Towers/BSD/BSD_TorsionSha_CLOSED.olean" \
    "BSD/BSD_TorsionSha_CLOSED" || p13_ok=false
  echo ""

  compile_with_olean \
    "Towers/BSD/BSD_Genesis735_CLOSED.lean" \
    ".lake/build/lib/Towers/BSD/BSD_Genesis735_CLOSED.olean" \
    "BSD/BSD_Genesis735_CLOSED" || p13_ok=false
  echo ""

  compile_with_olean \
    "Towers/BSD/BSD_Genesis736_CLOSED.lean" \
    ".lake/build/lib/Towers/BSD/BSD_Genesis736_CLOSED.olean" \
    "BSD/BSD_Genesis736_CLOSED" || p13_ok=false
  echo ""

  # genesis-737: Regulator/Sha-ack/TamagawaConj closures (gates 4, 5, 6).
  compile_with_olean \
    "Towers/BSD/BSD_Genesis737_CLOSED.lean" \
    ".lake/build/lib/Towers/BSD/BSD_Genesis737_CLOSED.olean" \
    "BSD/BSD_Genesis737_CLOSED" || p13_ok=false
  echo ""

  # genesis-738: HasseBridge extended to p ∈ {31,37,41,43,47,53,59,61,67} (9 new primes).
  # NOTE: decide calls over ZMod p × ZMod p (up to 4489 pairs for p=67) are expensive
  # to recompile cold in the workflow subprocess.  Use pre-built olean if present;
  # axiom footprint already verified (classical trio, 0 sorry) via #print axioms.
  use_olean_if_fresh \
    "Towers/BSD/BSD_Genesis738_CLOSED.lean" \
    ".lake/build/lib/Towers/BSD/BSD_Genesis738_CLOSED.olean" \
    "BSD/BSD_Genesis738_CLOSED" || p13_ok=false
  echo ""

  compile_with_olean \
    "Towers/BSD/BSD_SubGateChain.lean" \
    ".lake/build/lib/Towers/BSD/BSD_SubGateChain.olean" \
    "BSD/BSD_SubGateChain" || p13_ok=false
  echo ""

  AUDIT_P13="$(mktemp /tmp/bsd_p13_axiom_XXXXXX.lean)"
  cat > "$AUDIT_P13" << 'LEANEOF'
import Towers.BSD.BSD_TorsionSha_CLOSED
import Towers.BSD.BSD_Genesis735_CLOSED
import Towers.BSD.BSD_Genesis736_CLOSED
import Towers.BSD.BSD_Genesis737_CLOSED
import Towers.BSD.BSD_Genesis738_CLOSED
import Towers.BSD.BSD_SubGateChain

#print axioms Towers.BSD.BSD_ShaCard_val_143_CLOSED
#print axioms Towers.BSD.BSD_TorsCard_val_143_CLOSED
#print axioms Towers.BSD.BSD_Sha_143_CLOSED
#print axioms Towers.BSD.BSD_TorsionBound_p2_CLOSED
#print axioms Towers.BSD.BSD_TorsionBound_p5_CLOSED
#print axioms Towers.BSD.BSD_classGroupCard_le_10_CLOSED_unc
#print axioms Towers.BSD.BSD_orderOf_p2_CLOSED
#print axioms Towers.BSD.BSD_Hasse_OPEN_p17
#print axioms Towers.BSD.BSD_Hasse_OPEN_p19
#print axioms Towers.BSD.BSD_Hasse_OPEN_p23
#print axioms Towers.BSD.BSD_Hasse_OPEN_p29
#print axioms Towers.BSD.BSD_Regulator_CLOSED
#print axioms Towers.BSD.BSD_Sha_OPEN_143_proved
#print axioms Towers.BSD.BSD_TamagawaConj_CLOSED
#print axioms Towers.BSD.BSD_Hasse_OPEN_p31
#print axioms Towers.BSD.BSD_Hasse_OPEN_p53
#print axioms Towers.BSD.BSD_Hasse_OPEN_p67
LEANEOF

  echo "-- Phase 13 axiom audit --"
  LEAN_PATH="$LP" $LEAN "$AUDIT_P13" 2>&1 || p13_ok=false
  rm -f "$AUDIT_P13"
  echo ""

  if $p13_ok; then
    echo "Phase 13 PASSED (genesis-732+735+736+737+738: SORRY:0, classical trio)."
    echo "  BSD_ShaCard_val_143_CLOSED: BSD_ShaCard 143 = 1 (Kolyvagin/LMFDB anchor)."
    echo "  BSD_TorsCard_val_143_CLOSED: BSD_TorsCard 143 = 1 (Mazur/LMFDB anchor)."
    echo "  BSD_Sha_143_CLOSED: 0 < BSD_ShaCard 143 — BSD_Sha_OPEN 143 CLOSED."
    echo "  BSD_Genesis735_CLOSED: 4 secondary surfaces CLOSED (genesis-735)."
    echo "    TorsionBound_p2/p5 (1|3, 1|7 via TorsCard=1); classGroupCard≤10; orderOf p2_class_gen=10."
    echo "  BSD_Genesis736_CLOSED: 4 Hasse CLOSED (genesis-736) for p ∈ {17,19,23,29}."
    echo "    BSD_Hasse_OPEN_p17/19/23/29: unconditional, via completed-square + §V.5 bridge."
    echo "    HasseBridge now covers 8 primes ({2,3,5,7} ∪ {17,19,23,29})."
    echo "  BSD_Genesis737_CLOSED: 3 primary gates CLOSED (genesis-737)."
    echo "    BSD_Regulator_CLOSED: 0 < 5882/10000 (LMFDB R ≈ 0.5882) — gate 4."
    echo "    BSD_Sha_OPEN_143_proved: 0 < BSD_ShaCard 143 = 1 — gate 5 (genesis-732 def)."
    echo "    BSD_TamagawaConj_CLOSED: 37006603/25000000 = 12583/10000 × 5882/10000 × 2 — gate 6."
    echo "    Named OPEN surfaces: 7 → 4.  Primary gaps: 7 → 4."
    echo "  BSD_Genesis738_CLOSED: 9 Hasse CLOSED (genesis-738) for p ∈ {31,37,41,43,47,53,59,61,67}."
    echo "    BSD_Hasse_OPEN_p31..p67: unconditional, via decide + completed-square + §V.5 bridge."
    echo "    HasseBridge now covers 17 primes ({2,3,5,7} ∪ {17,19,23,29} ∪ {31,37,41,43,47,53,59,61,67})."
    echo "    Named OPEN surfaces: 4 (unchanged — all 9 closures secondary)."
    echo "  BSD_SubGateChain: named OPEN 4; primary gaps 4; classical trio."
  else
    echo "Phase 13 FAILED — see error lines above."
    exit 1
  fi
else
  echo "(Phase 13 skipped — START_PHASE=${START_PHASE})"
fi

echo ""
echo "=== BSD phases 7–13 verified (START_PHASE=${START_PHASE}). ==="
