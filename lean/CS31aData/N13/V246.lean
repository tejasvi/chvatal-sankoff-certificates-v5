import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 246 = cert_data/n13/h13c.vec.part0246, entries 23731372032 .. 23827841023, chunks 5658 .. 5680
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v246 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0246" 385875968 16777216

end CS31aData.N13
