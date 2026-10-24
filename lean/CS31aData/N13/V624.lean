import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 624 = cert_data/n13/h13c.vec.part0624, entries 60196651008 .. 60293119999, chunks 14352 .. 14374
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v624 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0624" 385875968 16777216

end CS31aData.N13
