import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1621 = cert_data/n13/h13c.vec.part1621, entries 156376236032 .. 156472705023, chunks 37283 .. 37305
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1621 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1621" 385875968 16777216

end CS31aData.N13
