import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1611 = cert_data/n13/h13c.vec.part1611, entries 155411546112 .. 155508015103, chunks 37053 .. 37075
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1611 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1611" 385875968 16777216

end CS31aData.N13
