import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1641 = cert_data/n13/h13c.vec.part1641, entries 158305615872 .. 158402084863, chunks 37743 .. 37765
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1641 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1641" 385875968 16777216

end CS31aData.N13
