import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1031 = cert_data/n13/h13c.vec.part1031, entries 99459530752 .. 99555999743, chunks 23713 .. 23735
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1031 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1031" 385875968 16777216

end CS31aData.N13
