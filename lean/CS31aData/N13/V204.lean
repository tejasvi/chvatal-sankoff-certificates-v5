import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 204 = cert_data/n13/h13c.vec.part0204, entries 19679674368 .. 19776143359, chunks 4692 .. 4714
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v204 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0204" 385875968 16777216

end CS31aData.N13
