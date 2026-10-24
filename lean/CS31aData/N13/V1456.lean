import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1456 = cert_data/n13/h13c.vec.part1456, entries 140458852352 .. 140555321343, chunks 33488 .. 33510
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1456 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1456" 385875968 16777216

end CS31aData.N13
