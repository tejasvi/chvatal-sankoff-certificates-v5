import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1193 = cert_data/n13/h13c.vec.part1193, entries 115087507456 .. 115183976447, chunks 27439 .. 27461
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1193 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1193" 385875968 16777216

end CS31aData.N13
