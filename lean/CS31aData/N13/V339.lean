import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 339 = cert_data/n13/h13c.vec.part0339, entries 32702988288 .. 32799457279, chunks 7797 .. 7819
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v339 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0339" 385875968 16777216

end CS31aData.N13
