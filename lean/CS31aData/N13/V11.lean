import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 11 = cert_data/n13/h13c.vec.part0011, entries 1061158912 .. 1157627903, chunks 253 .. 275
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v11 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0011" 385875968 16777216

end CS31aData.N13
