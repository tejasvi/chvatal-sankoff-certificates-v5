import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1013 = cert_data/n13/h13c.vec.part1013, entries 97723088896 .. 97819557887, chunks 23299 .. 23321
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1013 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1013" 385875968 16777216

end CS31aData.N13
