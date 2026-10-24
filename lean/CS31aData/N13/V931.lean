import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 931 = cert_data/n13/h13c.vec.part0931, entries 89812631552 .. 89909100543, chunks 21413 .. 21435
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v931 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0931" 385875968 16777216

end CS31aData.N13
