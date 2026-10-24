import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1361 = cert_data/n13/h13c.vec.part1361, entries 131294298112 .. 131390767103, chunks 31303 .. 31325
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1361 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1361" 385875968 16777216

end CS31aData.N13
