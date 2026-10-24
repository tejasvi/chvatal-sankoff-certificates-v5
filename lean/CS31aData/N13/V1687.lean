import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1687 = cert_data/n13/h13c.vec.part1687, entries 162743189504 .. 162839658495, chunks 38801 .. 38823
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1687 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1687" 385875968 16777216

end CS31aData.N13
