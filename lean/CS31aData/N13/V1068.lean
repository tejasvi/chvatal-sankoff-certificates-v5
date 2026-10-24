import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1068 = cert_data/n13/h13c.vec.part1068, entries 103028883456 .. 103125352447, chunks 24564 .. 24586
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1068 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1068" 385875968 16777216

end CS31aData.N13
