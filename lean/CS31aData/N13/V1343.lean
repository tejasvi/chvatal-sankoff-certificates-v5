import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1343 = cert_data/n13/h13c.vec.part1343, entries 129557856256 .. 129654325247, chunks 30889 .. 30911
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1343 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1343" 385875968 16777216

end CS31aData.N13
