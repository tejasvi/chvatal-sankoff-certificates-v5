import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 740 = cert_data/n13/h13c.vec.part0740, entries 71387054080 .. 71483523071, chunks 17020 .. 17042
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v740 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0740" 385875968 16777216

end CS31aData.N13
