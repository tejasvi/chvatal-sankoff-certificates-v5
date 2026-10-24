import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 235 = cert_data/n13/h13c.vec.part0235, entries 22670213120 .. 22766682111, chunks 5405 .. 5427
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v235 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0235" 385875968 16777216

end CS31aData.N13
