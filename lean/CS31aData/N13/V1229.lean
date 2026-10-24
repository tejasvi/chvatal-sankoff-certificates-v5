import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1229 = cert_data/n13/h13c.vec.part1229, entries 118560391168 .. 118656860159, chunks 28267 .. 28289
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1229 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1229" 385875968 16777216

end CS31aData.N13
