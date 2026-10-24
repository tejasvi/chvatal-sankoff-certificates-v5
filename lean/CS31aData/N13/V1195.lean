import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1195 = cert_data/n13/h13c.vec.part1195, entries 115280445440 .. 115376914431, chunks 27485 .. 27507
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1195 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1195" 385875968 16777216

end CS31aData.N13
