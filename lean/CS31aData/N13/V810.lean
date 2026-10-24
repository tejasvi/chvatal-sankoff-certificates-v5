import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 810 = cert_data/n13/h13c.vec.part0810, entries 78139883520 .. 78236352511, chunks 18630 .. 18652
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v810 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0810" 385875968 16777216

end CS31aData.N13
