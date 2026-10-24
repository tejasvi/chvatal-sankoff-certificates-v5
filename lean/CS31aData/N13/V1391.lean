import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1391 = cert_data/n13/h13c.vec.part1391, entries 134188367872 .. 134284836863, chunks 31993 .. 32015
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1391 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1391" 385875968 16777216

end CS31aData.N13
