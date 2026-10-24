import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1039 = cert_data/n13/h13c.vec.part1039, entries 100231282688 .. 100327751679, chunks 23897 .. 23919
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1039 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1039" 385875968 16777216

end CS31aData.N13
