import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1244 = cert_data/n13/h13c.vec.part1244, entries 120007426048 .. 120103895039, chunks 28612 .. 28634
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1244 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1244" 385875968 16777216

end CS31aData.N13
