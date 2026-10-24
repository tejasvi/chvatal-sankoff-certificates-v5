import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1349 = cert_data/n13/h13c.vec.part1349, entries 130136670208 .. 130233139199, chunks 31027 .. 31049
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1349 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1349" 385875968 16777216

end CS31aData.N13
