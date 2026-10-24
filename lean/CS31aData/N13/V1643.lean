import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1643 = cert_data/n13/h13c.vec.part1643, entries 158498553856 .. 158595022847, chunks 37789 .. 37811
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1643 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1643" 385875968 16777216

end CS31aData.N13
