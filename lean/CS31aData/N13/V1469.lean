import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1469 = cert_data/n13/h13c.vec.part1469, entries 141712949248 .. 141809418239, chunks 33787 .. 33809
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1469 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1469" 385875968 16777216

end CS31aData.N13
