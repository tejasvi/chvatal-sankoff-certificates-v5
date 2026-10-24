import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 537 = cert_data/n13/h13c.vec.part0537, entries 51803848704 .. 51900317695, chunks 12351 .. 12373
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v537 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0537" 385875968 16777216

end CS31aData.N13
