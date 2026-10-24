import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 409 = cert_data/n13/h13c.vec.part0409, entries 39455817728 .. 39552286719, chunks 9407 .. 9429
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v409 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0409" 385875968 16777216

end CS31aData.N13
