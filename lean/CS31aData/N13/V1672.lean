import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1672 = cert_data/n13/h13c.vec.part1672, entries 161296154624 .. 161392623615, chunks 38456 .. 38478
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1672 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1672" 385875968 16777216

end CS31aData.N13
