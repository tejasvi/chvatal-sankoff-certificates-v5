import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1470 = cert_data/n13/h13c.vec.part1470, entries 141809418240 .. 141905887231, chunks 33810 .. 33832
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1470 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1470" 385875968 16777216

end CS31aData.N13
