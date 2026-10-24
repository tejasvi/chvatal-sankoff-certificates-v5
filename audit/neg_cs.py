#!/usr/bin/env python3
"""Negative tests for the audit checker mhcheck on a Chvatal-Sankoff certificate (keys, v, z, LAM).
Each modified certificate must FAIL.  Modified files are written to neg/ next to this script and deleted at the end.
Usage: python -I neg_cs.py H KEYS V ZDEC LAM LEAST_LAM THREADS"""
import sys, os, subprocess, numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from weights_bound import weights

h, kpath, vpath, zdec, lam, least, thr = sys.argv[1:8]
h = int(h); lam = int(lam); least = int(least)
W = ",".join(str(w) for w in weights(h, zdec))
neg = os.path.join(HERE, "neg"); os.makedirs(neg, exist_ok=True)
env = dict(os.environ, TMPDIR=os.path.join(HERE, "tmp"))


def run(name, k, v, wts, L):
    r = subprocess.run(["nice", "-n", "10", os.path.join(HERE, "mhcheck"), str(h), k, v, wts, str(L), thr],
                       capture_output=True, text=True, env=env)
    out = (r.stdout + r.stderr).strip().splitlines()
    verdict = "REJECTED" if r.returncode != 0 else "ACCEPTED"
    print(f"{name:34s} {verdict:9s} | {' | '.join(o[:150] for o in out[:2])}", flush=True)


keys = np.memmap(kpath, dtype="<u8", mode="r"); v = np.memmap(vpath, dtype="<f8", mode="r")
N = len(keys)
# 1. lambda just below the least passing value
run("lambda = least - 1", kpath, vpath, W, least - 1)
# 2. wrong z (weights for a slightly larger z, same v and LAM)
zbad = str(float(zdec) + 0.0001)
run(f"weights for z = {zbad}", kpath, vpath, ",".join(str(w) for w in weights(h, zbad)), lam)
# 3. perturbed v entries
q0 = (((1 << h) - 1) << h) | ((1 << h) - 1)
vr = np.array(v); kr = np.array(keys)
for name, idx, fac in (("v[argmax row] * (1 - 1e-12)", int(os.environ["ARGMAX_IDX"]), 1 - 1e-12),
                       ("v[q0] * 0.5", int(np.searchsorted(kr, q0)), 0.5),
                       ("v[random state] * 2", 12345, 2.0)):
    vv = vr.copy(); vv[idx] = vv[idx] * fac
    p = os.path.join(neg, "v_mod.bin"); vv.astype("<f8").tofile(p)
    run(name, kpath, p, W, lam)
# 4. missing states: a random non-start state, and the start state
for name, idx in (("one random state removed", 777777 % N), ("start state removed", int(np.searchsorted(kr, q0)))):
    sel = np.ones(N, bool); sel[idx] = False
    pk = os.path.join(neg, "k_mod.bin"); pv = os.path.join(neg, "v_mod.bin")
    kr[sel].astype("<u8").tofile(pk); vr[sel].astype("<f8").tofile(pv)
    run(name, pk, pv, W, lam)
# 5. a non-positive v entry
vv = vr.copy(); vv[54321] = 0.0
p = os.path.join(neg, "v_mod.bin"); vv.astype("<f8").tofile(p)
run("v[54321] = 0", kpath, p, W, lam)
for f in ("v_mod.bin", "k_mod.bin"):
    fp = os.path.join(neg, f)
    if os.path.exists(fp):
        os.remove(fp)
