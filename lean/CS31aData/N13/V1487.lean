import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1487 = cert_data/n13/h13c.vec.part1487, entries 143449391104 .. 143545860095, chunks 34201 .. 34223
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1487 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1487" 385875968 16777216

end CS31aData.N13
