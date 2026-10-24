import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1474 = cert_data/n13/h13c.vec.part1474, entries 142195294208 .. 142291763199, chunks 33902 .. 33924
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1474 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1474" 385875968 16777216

end CS31aData.N13
