import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 240 = cert_data/n13/h13c.vec.part0240, entries 23152558080 .. 23249027071, chunks 5520 .. 5542
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v240 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0240" 385875968 16777216

end CS31aData.N13
