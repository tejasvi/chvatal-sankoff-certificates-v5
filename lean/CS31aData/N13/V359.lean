import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 359 = cert_data/n13/h13c.vec.part0359, entries 34632368128 .. 34728837119, chunks 8257 .. 8279
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v359 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0359" 385875968 16777216

end CS31aData.N13
