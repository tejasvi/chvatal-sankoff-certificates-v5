import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 930 = cert_data/n13/h13c.vec.part0930, entries 89716162560 .. 89812631551, chunks 21390 .. 21412
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v930 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0930" 385875968 16777216

end CS31aData.N13
