import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1201 = cert_data/n13/h13c.vec.part1201, entries 115859259392 .. 115955728383, chunks 27623 .. 27645
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1201 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1201" 385875968 16777216

end CS31aData.N13
