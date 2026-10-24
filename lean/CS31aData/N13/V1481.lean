import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1481 = cert_data/n13/h13c.vec.part1481, entries 142870577152 .. 142967046143, chunks 34063 .. 34085
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1481 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1481" 385875968 16777216

end CS31aData.N13
