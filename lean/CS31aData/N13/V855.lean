import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 855 = cert_data/n13/h13c.vec.part0855, entries 82480988160 .. 82577457151, chunks 19665 .. 19687
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v855 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0855" 385875968 16777216

end CS31aData.N13
