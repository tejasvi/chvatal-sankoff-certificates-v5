import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 491 = cert_data/n13/h13c.vec.part0491, entries 47366275072 .. 47462744063, chunks 11293 .. 11315
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v491 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0491" 385875968 16777216

end CS31aData.N13
