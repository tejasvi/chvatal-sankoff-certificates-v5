import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1427 = cert_data/n13/h13c.vec.part1427, entries 137661251584 .. 137757720575, chunks 32821 .. 32843
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1427 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1427" 385875968 16777216

end CS31aData.N13
