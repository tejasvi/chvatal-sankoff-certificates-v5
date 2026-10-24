import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1275 = cert_data/n13/h13c.vec.part1275, entries 122997964800 .. 123094433791, chunks 29325 .. 29347
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1275 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1275" 385875968 16777216

end CS31aData.N13
