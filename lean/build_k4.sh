#!/bin/bash
# Build CS31aK.H9 as in the record build: lake builds the library prerequisites, then one `lean` per generated module
# (data; shard modules in parallel, 16 `decide +kernel` theorems each, single-threaded; groups in parallel; top) under a
# virtual-memory cap. Run from the snapshot root with cert_data/h9_keys.bin and cert_data/h9_v_0.329800.bin present.
# usage: ./build_k4.sh P MEMGB   (record: P = 88-120 per machine, MEMGB = 96; shard modules need ~4 GB resident,
# groups ~8 GB, the top ~9 GB; thread creation fails under caps around 24 GB because of the 1.35 GB data olean)
set -u
cd "$(dirname "$0")"
H=9; P=$1; MEMGB=$2
mkdir -p logs/k$H
L=logs/k$H/build.log
echo "=== start $(date -u +%FT%TZ) P=$P MEMGB=$MEMGB" >> $L
lake build CS31a.KSplit CS31a.Assemble CS31a.Count CS31a.CoverExists CS31aData.KElab CS31aCert.KFast \
  CS31aCert.Bytes:dynlib CS31aCert.Step:dynlib CS31aCert.Row:dynlib CS31aCert.KTree:dynlib CS31aCert.KStep:dynlib \
  >> $L 2>&1 || { echo "prebuild failed" >> $L; exit 1; }
export D=.lake/build/lib/lean
export LP=$(lake env printenv LEAN_PATH)
export MEMKB=$((MEMGB * 1024 * 1024))
export LEAN_NUM_THREADS=1
export H
one() {
  local M=$1; local F=$(echo $M | tr . /).lean; local O=$D/$(echo $M | tr . /)
  mkdir -p $(dirname $O)
  ( ulimit -v $MEMKB; LEAN_PATH=$LP /usr/bin/time -f "%e s %M KB" lean --load-dynlib=$D/CS31a_CS31aCert_Bytes.so \
      --load-dynlib=$D/CS31a_CS31aCert_Step.so --load-dynlib=$D/CS31a_CS31aCert_Row.so \
      --load-dynlib=$D/CS31a_CS31aCert_KTree.so --load-dynlib=$D/CS31a_CS31aCert_KStep.so \
      $F -o $O.olean -i $O.ilean > logs/k$H/$M.out 2>&1 )
  echo "$M rc=$? $(tail -1 logs/k$H/$M.out)" >> logs/k$H/rc.log
}
export -f one
one CS31aK.H9.Data
echo "=== shards $(date -u +%FT%TZ)" >> $L
ls CS31aK/H9/S*.lean | sed 's/\.lean$//; s/\//./g' | xargs -P $P -I{} bash -c 'one {}'
echo "=== groups $(date -u +%FT%TZ)" >> $L
ls CS31aK/H9/G*.lean | sed 's/\.lean$//; s/\//./g' | xargs -P $P -I{} bash -c 'one {}'
echo "=== top $(date -u +%FT%TZ)" >> $L
one CS31aK.H9
echo "modules: $(wc -l < logs/k$H/rc.log), failures: $(grep -vc 'rc=0' logs/k$H/rc.log)" >> $L
echo "=== end $(date -u +%FT%TZ)" >> $L
tail -3 $L
