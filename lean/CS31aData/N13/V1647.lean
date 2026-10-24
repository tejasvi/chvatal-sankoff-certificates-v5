import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1647 = cert_data/n13/h13c.vec.part1647, entries 158884429824 .. 158980898815, chunks 37881 .. 37903
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1647 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1647" 385875968 16777216

end CS31aData.N13
