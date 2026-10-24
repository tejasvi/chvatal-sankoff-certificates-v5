import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 827 = cert_data/n13/h13c.vec.part0827, entries 79779856384 .. 79876325375, chunks 19021 .. 19043
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v827 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0827" 385875968 16777216

end CS31aData.N13
