import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1280 = cert_data/n13/h13c.vec.part1280, entries 123480309760 .. 123576778751, chunks 29440 .. 29462
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1280 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1280" 385875968 16777216

end CS31aData.N13
