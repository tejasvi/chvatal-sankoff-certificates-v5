import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 853 = cert_data/n13/h13c.vec.part0853, entries 82288050176 .. 82384519167, chunks 19619 .. 19641
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v853 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0853" 385875968 16777216

end CS31aData.N13
