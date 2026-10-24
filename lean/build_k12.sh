#!/bin/bash
# Build CS31aK.H12 as in the original build (lane-packed checker, split mode): lake builds the library prerequisites; the h = 12
# certificate is cut into the 256 part files of CS31aK/H12/parts.tsv (tools_split_parts.py); the 256 sub-data modules D<i>[suffix]
# (in parallel) and Data are built with `lean -o` and the CS31aCert dynlibs; then the 524,288 shard
# modules S<m> (one theorem mod<m> each, proved by `kl_split 7`: 128 subtrees, each checked by `decide +kernel` in its own
# auxiliary lemma; single-threaded, in parallel), the 8,192 groups G<g> and the top CS31aK.H12.
# Run from the project root with cert_data/h12_keys.bin and cert_data/h12_vdet_0.350500.bin present.
# usage: ./build_k12.sh P MEMGB   (original build, peak resident memory in GiB: shard modules 2.1, at most 5.6, and 390-520 s each
# on a 360-vCPU machine under full load; sub-data modules 7.4 / ~160 s each; Data 26.0 / 13 s; groups at most 3.3 / ~2 s each; the
# top 194.9 / 884 s. Every shard module maps all 256 sub-data oleans (446 GiB, shared page cache) and Lean counts the mapping against
# the cap: the original build used MEMGB = 1024 (96 failed); RAM about 450 GiB plus 2-6 GiB per parallel shard module)
set -u
cd "$(dirname "$0")"
H=12; P=$1; MEMGB=$2
mkdir -p logs/k$H
L=logs/k$H/build.log
echo "=== start $(date -u +%FT%TZ) P=$P MEMGB=$MEMGB" >> $L
lake build CS31a.KLSplit CS31a.KLaneSound CS31a.Assemble CS31a.Count CS31a.CoverExists CS31aData.KElab CS31aCert.KLane \
  CS31aCert.Bytes:dynlib CS31aCert.Step:dynlib CS31aCert.Row:dynlib CS31aCert.KTree:dynlib CS31aCert.KStep:dynlib \
  >> $L 2>&1 || { echo "prebuild failed" >> $L; exit 1; }
PD=$(grep -o 'ktree_of_files% "[^"]*/k0.bin' CS31aK/H$H/D0*.lean | head -1 | sed 's/.*ktree_of_files% "//; s|/k0.bin||')
[ -s $PD/k255.bin ] || python3 -I -B tools_split_parts.py cert_data/h12_keys.bin cert_data/h12_vdet_0.350500.bin CS31aK/H$H/parts.tsv $PD \
  >> $L 2>&1 || { echo "split failed" >> $L; exit 1; }
export D=.lake/build/lib/lean
export LP=$(lake env printenv LEAN_PATH)
export MEMKB=$((MEMGB * 1024 * 1024))
export LEAN_NUM_THREADS=1
export H
data() {   # sub-data and data modules: with the dynlibs of the file-reading elaborator
  local M=$1; local F=$(echo $M | tr . /).lean; local O=$D/$(echo $M | tr . /)
  mkdir -p $(dirname $O)
  ( LEAN_PATH=$LP /usr/bin/time -f "%e s %M KB" lean --load-dynlib=$D/CS31a_CS31aCert_Bytes.so \
      --load-dynlib=$D/CS31a_CS31aCert_Step.so --load-dynlib=$D/CS31a_CS31aCert_Row.so \
      --load-dynlib=$D/CS31a_CS31aCert_KTree.so --load-dynlib=$D/CS31a_CS31aCert_KStep.so \
      $F -o $O.olean -i $O.ilean > logs/k$H/$M.out 2>&1 )
  echo "$M rc=$? $(tail -1 logs/k$H/$M.out)" >> logs/k$H/rc.log
}
one() {    # shard, group and top modules: kernel checking only
  local M=$1; local F=$(echo $M | tr . /).lean; local O=$D/$(echo $M | tr . /)
  mkdir -p $(dirname $O)
  ( ulimit -v $MEMKB; LEAN_PATH=$LP /usr/bin/time -f "%e s %M KB" lean $F -o $O.olean -i $O.ilean > logs/k$H/$M.out 2>&1 )
  echo "$M rc=$? $(tail -1 logs/k$H/$M.out)" >> logs/k$H/rc.log
}
export -f data one
echo "=== sub-data $(date -u +%FT%TZ)" >> $L
ls CS31aK/H$H/D[0-9]*.lean | sed 's/\.lean$//; s/\//./g' | xargs -P $P -I{} bash -c 'data {}'
data CS31aK.H$H.Data
echo "=== shards $(date -u +%FT%TZ)" >> $L
ls CS31aK/H$H/S*.lean | sed 's/\.lean$//; s/\//./g' | xargs -P $P -I{} bash -c 'one {}'
echo "=== groups $(date -u +%FT%TZ)" >> $L
ls CS31aK/H$H/G*.lean | sed 's/\.lean$//; s/\//./g' | xargs -P $P -I{} bash -c 'one {}'
echo "=== top $(date -u +%FT%TZ)" >> $L
one CS31aK.H$H
echo "modules: $(wc -l < logs/k$H/rc.log), failures: $(grep -vc 'rc=0' logs/k$H/rc.log)" >> $L
echo "=== end $(date -u +%FT%TZ)" >> $L
tail -3 $L
