import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1052 = cert_data/n13/h13c.vec.part1052, entries 101485379584 .. 101581848575, chunks 24196 .. 24218
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1052 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1052" 385875968 16777216

end CS31aData.N13
