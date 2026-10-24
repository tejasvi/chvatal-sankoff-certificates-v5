import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1196 = cert_data/n13/h13c.vec.part1196, entries 115376914432 .. 115473383423, chunks 27508 .. 27530
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1196 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1196" 385875968 16777216

end CS31aData.N13
