import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 179 = cert_data/n13/h13c.vec.part0179, entries 17267949568 .. 17364418559, chunks 4117 .. 4139
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v179 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0179" 385875968 16777216

end CS31aData.N13
