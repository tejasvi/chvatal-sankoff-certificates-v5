import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 988 = cert_data/n13/h13c.vec.part0988, entries 95311364096 .. 95407833087, chunks 22724 .. 22746
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v988 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0988" 385875968 16777216

end CS31aData.N13
