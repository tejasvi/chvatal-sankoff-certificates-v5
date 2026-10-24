import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1178 = cert_data/n13/h13c.vec.part1178, entries 113640472576 .. 113736941567, chunks 27094 .. 27116
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1178 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1178" 385875968 16777216

end CS31aData.N13
