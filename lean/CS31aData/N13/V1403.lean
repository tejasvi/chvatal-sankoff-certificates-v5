import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1403 = cert_data/n13/h13c.vec.part1403, entries 135345995776 .. 135442464767, chunks 32269 .. 32291
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1403 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1403" 385875968 16777216

end CS31aData.N13
