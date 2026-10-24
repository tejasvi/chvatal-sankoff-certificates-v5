import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1384 = cert_data/n13/h13c.vec.part1384, entries 133513084928 .. 133609553919, chunks 31832 .. 31854
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1384 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1384" 385875968 16777216

end CS31aData.N13
