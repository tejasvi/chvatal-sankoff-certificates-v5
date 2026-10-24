import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1016 = cert_data/n13/h13c.vec.part1016, entries 98012495872 .. 98108964863, chunks 23368 .. 23390
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1016 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1016" 385875968 16777216

end CS31aData.N13
