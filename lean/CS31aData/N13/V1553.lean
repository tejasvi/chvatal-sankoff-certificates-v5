import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1553 = cert_data/n13/h13c.vec.part1553, entries 149816344576 .. 149912813567, chunks 35719 .. 35741
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1553 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1553" 385875968 16777216

end CS31aData.N13
