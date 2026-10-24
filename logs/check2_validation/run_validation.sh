#!/bin/bash
# Full validation of the frozen check2.cpp (see VALIDATION_check2.md).  Outputs in logs/val/.
export TMPDIR=WORKDIR/tmp OMP_NUM_THREADS=16
cd WORKDIR
D=../data
L=logs/val
VT=vt
mkdir -p $L $VT
S="$L/summary.txt"
: > $S
log() { echo "$*" | tee -a $S; }

log "start $(date -u +%FT%TZ)"
sha256sum check2.cpp harness.cpp walk.cpp bench.cpp mkvec.cpp ../src/check.cpp | tee -a $S
g++ --version | head -1 | tee -a $S

# ---- builds (flags recorded) ----
B="nice -n 10 g++"
$B -O3 -fopenmp -Wall -Wextra -o check2 check2.cpp && \
$B -O3 -fopenmp -o check_ref ../src/check.cpp && \
$B -O3 -fopenmp -o harness harness.cpp 2>/dev/null && \
$B -O2 -fopenmp -DC2_DEBUG -o harness_dbg harness.cpp 2>/dev/null && \
$B -O3 -fopenmp -o walk walk.cpp 2>/dev/null && \
$B -O2 -fopenmp -DC2_DEBUG -o walk_dbg walk.cpp 2>/dev/null && \
$B -O3 -fopenmp -o bench bench.cpp 2>/dev/null && \
$B -O2 -Wall -o mkvec mkvec.cpp || { log "BUILD FAILED"; exit 1; }
log "builds: check2/check_ref/harness/walk/bench -O3 -fopenmp; harness_dbg/walk_dbg -O2 -fopenmp -DC2_DEBUG"
sha256sum check2 check_ref | tee -a $S

# run NAME CMD... : stdout -> NAME.out, stderr -> NAME.err, resources -> NAME.time
run() {
  local name=$1; shift
  nice -n 10 /usr/bin/time -f "wall=%e user=%U sys=%S maxrss_kb=%M" -o $L/$name.time "$@" > $L/$name.out 2> $L/$name.err
  local rc=$?
  log "[$name] rc=$rc $(tr '\n' ' ' < $L/$name.time)"
  grep -vE "^CLAIM" $L/$name.out | head -5 | sed 's/^/    /' | tee -a $S
  grep -E "^(FAIL|internal|size mismatch|check2: lam_num|check2: main)" $L/$name.err | head -3 | sed 's/^/    err: /' | tee -a $S
}

# ---- 1. transition level ----
log "== 1. transitions: check2 successors() vs check.cpp step(), every input of every state"
for H in 2 3 4 5 6 7 8 9 10; do run trans_h$H ./harness trans $H $D/h${H}_keys.bin; done
for H in 2 3 4 5 6 7 8 9 10; do run transdbg_h$H ./harness_dbg trans $H $D/h${H}_keys.bin; done
for H in 11 12 13 14 15; do run walk_h$H ./walk $H 256 40000 $H; done
for H in 11 12 13 14 15; do run walkdbg_h$H ./walk_dbg $H 64 20000 $((H+100)); done

# ---- 2. decoding of v ----
log "== 2. v decoding vs check.cpp's frexp method"
run f32all ./harness f32all
run f64_h8 ./harness f64 $D/h8_v_0.320900.bin 100000000
run f64_h9 ./harness f64 $D/h9_v_0.329800.bin 0
run f64_h10 ./harness f64 $D/h10_v_0.337600.bin 0

# ---- 3. transition cost alone ----
log "== 3. transition part alone (no lookups): check2 successors() vs check.cpp step()"
run bench_dp_h9 ./bench dp 9 $D/h9_keys.bin
run bench_step_h9 ./bench step 9 $D/h9_keys.bin

# ---- 4. certificates ----
log "== 4. certificate runs"
run c2_h8 ./check2 8 $D/h8_keys.bin $D/h8_v_0.320900.bin $D/w_h8_0.3209.txt
run c2_h9 ./check2 9 $D/h9_keys.bin $D/h9_v_0.329800.bin $D/w_h9_0.3298.txt
run c2_h10 ./check2 10 $D/h10_keys.bin $D/h10_v_0.337600.bin $D/w_h10_0.3376.txt
run c2_h10_B24 ./check2 10 $D/h10_keys.bin $D/h10_v_0.337600.bin $D/w_h10_0.3376.txt --index-bits 24 --no-thp

# ---- 5. split runs ----
log "== 5. split runs"
run c2_h10_r0 ./check2 10 $D/h10_keys.bin $D/h10_v_0.337600.bin $D/w_h10_0.3376.txt --rows 0 100000000
run c2_h10_r1 ./check2 10 $D/h10_keys.bin $D/h10_v_0.337600.bin $D/w_h10_0.3376.txt --rows 100000000 250000000 --segments 4
run c2_h10_r2 ./check2 10 $D/h10_keys.bin $D/h10_v_0.337600.bin $D/w_h10_0.3376.txt --rows 250000000 400253317
N9=51425006
run c2_h9_r0 ./check2 9 $D/h9_keys.bin $D/h9_v_0.329800.bin $D/w_h9_0.3298.txt --rows 0 12000000
run c2_h9_r1 ./check2 9 $D/h9_keys.bin $D/h9_v_0.329800.bin $D/w_h9_0.3298.txt --rows 12000000 25712503
run c2_h9_r2 ./check2 9 $D/h9_keys.bin $D/h9_v_0.329800.bin $D/w_h9_0.3298.txt --rows 25712503 40000001
run c2_h9_r3 ./check2 9 $D/h9_keys.bin $D/h9_v_0.329800.bin $D/w_h9_0.3298.txt --rows 40000001 $N9
run c2_h9_seg ./check2 9 $D/h9_keys.bin $D/h9_v_0.329800.bin $D/w_h9_0.3298.txt --segments 7

# ---- 6. binary32 vectors ----
log "== 6. --f32"
nice -n 10 ./mkvec f32 $D/h9_v_0.329800.bin $VT/h9_v_f32.bin $VT/h9_v_f32as64.bin | tee -a $S
nice -n 10 ./mkvec f32 $D/h8_v_0.320900.bin $VT/h8_v_f32.bin $VT/h8_v_f32as64.bin | tee -a $S
sha256sum $VT/h9_v_f32.bin $VT/h9_v_f32as64.bin | tee -a $S
run ref_h9_f32as64 ./check_ref 9 $D/h9_keys.bin $VT/h9_v_f32as64.bin $D/w_h9_0.3298.txt
run c2_h9_f32 ./check2 9 $D/h9_keys.bin $VT/h9_v_f32.bin $D/w_h9_0.3298.txt --f32
run c2_h9_f32as64 ./check2 9 $D/h9_keys.bin $VT/h9_v_f32as64.bin $D/w_h9_0.3298.txt
run c2_h9_f32_r0 ./check2 9 $D/h9_keys.bin $VT/h9_v_f32.bin $D/w_h9_0.3298.txt --f32 --rows 0 30000000
run c2_h9_f32_r1 ./check2 9 $D/h9_keys.bin $VT/h9_v_f32.bin $D/w_h9_0.3298.txt --f32 --rows 30000000 $N9

# ---- 6b. combining split outputs ----
log "== 6b. combine_check2.py on the split outputs"
comb() { local name=$1; shift; python3 -I combine_check2.py "$@" > $L/$name.txt 2>&1; log "[$name] rc=$?"; tail -3 $L/$name.txt | sed 's/^/    /' | tee -a $S; }
comb combine_h10 $L/c2_h10_r0.out $L/c2_h10_r1.out $L/c2_h10_r2.out
comb combine_h9 $L/c2_h9_r0.out $L/c2_h9_r1.out $L/c2_h9_r2.out $L/c2_h9_r3.out
comb combine_h9_seg $L/c2_h9_seg.out
comb combine_h9_f32 $L/c2_h9_f32_r0.out $L/c2_h9_f32_r1.out
comb combine_h9_gap $L/c2_h9_r0.out $L/c2_h9_r1.out $L/c2_h9_r3.out          # rows 25712503-40000001 missing: must be rejected
comb combine_h9_mixed $L/c2_h9_r0.out $L/c2_h9_f32_r1.out                    # different v: must be rejected

# ---- 7. negative tests (h = 8; both checkers) ----
log "== 7. negative tests"
K8=$D/h8_keys.bin; V8=$D/h8_v_0.320900.bin; W8=$D/w_h8_0.3209.txt
I=3209554; IA=3063572   # IA = first row attaining lam_num at h=8
IS=$(./mkvec find $K8 ffff); log "start state index at h=8: $IS"
neg() {  # neg NAME KEYS VEC [extra check2 args] ; ref gets the binary64 file in $NEGREFVEC if set
  local name=$1 k=$2 v=$3; shift 3
  run ref_$name ./check_ref 8 $k ${NEGREFVEC:-$v} $W8
  run c2_$name ./check2 8 $k $v $W8 "$@"
}
./mkvec scale $V8 $VT/v8_tight.bin $IA 1073741823 1073741824 | tee -a $S;  neg tight $K8 $VT/v8_tight.bin
./mkvec scale $V8 $VT/v8_half.bin $I 1 2 | tee -a $S;                     neg half $K8 $VT/v8_half.bin
./mkvec scale $V8 $VT/v8_double.bin $I 2 1 | tee -a $S;                   neg double $K8 $VT/v8_double.bin
./mkvec drop $K8 $V8 $VT/k8_drop.bin $VT/v8_drop.bin $I | tee -a $S;     neg dropstate $VT/k8_drop.bin $VT/v8_drop.bin
./mkvec drop $K8 $V8 $VT/k8_nostart.bin $VT/v8_nostart.bin $IS | tee -a $S; neg nostart $VT/k8_nostart.bin $VT/v8_nostart.bin
./mkvec setbits $V8 $VT/v8_zero.bin $I 0 | tee -a $S;                     neg zero $K8 $VT/v8_zero.bin
./mkvec scale $V8 $VT/v8_neg.bin $I -1 1 | tee -a $S;                     neg negative $K8 $VT/v8_neg.bin
./mkvec setbits $V8 $VT/v8_nan.bin $I 7ff8000000000000 | tee -a $S;      neg nan $K8 $VT/v8_nan.bin
./mkvec setbits $V8 $VT/v8_sub.bin $I 1 | tee -a $S;                      neg subnormal64 $K8 $VT/v8_sub.bin
./mkvec swapkeys $K8 $VT/k8_swap.bin $I | tee -a $S;                      neg unsorted $VT/k8_swap.bin $V8
./mkvec setkey $K8 $VT/k8_range.bin 6419108 100000000 | tee -a $S;        neg keyrange $VT/k8_range.bin $V8
head -c 51352864 $V8 > $VT/v8_trunc.bin;                                  neg sizemismatch $K8 $VT/v8_trunc.bin
./mkvec setbits32 $VT/h8_v_f32.bin $VT/v8f_zero.bin $I 0 | tee -a $S
./mkvec setbits $VT/h8_v_f32as64.bin $VT/v8f_zero_as64.bin $I 0 | tee -a $S
NEGREFVEC=$VT/v8f_zero_as64.bin neg f32zero $K8 $VT/v8f_zero.bin --f32
./mkvec setbits32 $VT/h8_v_f32.bin $VT/v8f_sub.bin $I 1 | tee -a $S
./mkvec setbits $VT/h8_v_f32as64.bin $VT/v8f_sub_as64.bin $I 36a0000000000000 | tee -a $S   # 2^-149 as binary64
NEGREFVEC=$VT/v8f_sub_as64.bin neg f32subnormal $K8 $VT/v8f_sub.bin --f32
NEGREFVEC=$VT/h8_v_f32as64.bin neg f32plain $K8 $VT/h8_v_f32.bin --f32

# ---- 8. timing at h = 10 (same thread count, alternating) ----
log "== 8. timing h=10, OMP_NUM_THREADS=$OMP_NUM_THREADS"
for rep in 1 2; do
  run time_ref_h10_$rep ./check_ref 10 $D/h10_keys.bin $D/h10_v_0.337600.bin $D/w_h10_0.3376.txt
  run time_c2_h10_$rep ./check2 10 $D/h10_keys.bin $D/h10_v_0.337600.bin $D/w_h10_0.3376.txt
done
log "end $(date -u +%FT%TZ)"
sha256sum check2.cpp | tee -a $S
echo DONE >> $S
