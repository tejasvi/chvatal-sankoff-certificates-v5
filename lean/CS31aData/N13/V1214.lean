import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1214 = cert_data/n13/h13c.vec.part1214, entries 117113356288 .. 117209825279, chunks 27922 .. 27944
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1214 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1214" 385875968 16777216

end CS31aData.N13
