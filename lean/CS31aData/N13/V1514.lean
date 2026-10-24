import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1514 = cert_data/n13/h13c.vec.part1514, entries 146054053888 .. 146150522879, chunks 34822 .. 34844
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1514 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1514" 385875968 16777216

end CS31aData.N13
