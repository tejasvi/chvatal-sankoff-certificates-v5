import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1628 = cert_data/n13/h13c.vec.part1628, entries 157051518976 .. 157147987967, chunks 37444 .. 37466
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1628 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1628" 385875968 16777216

end CS31aData.N13
