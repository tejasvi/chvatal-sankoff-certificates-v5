import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 587 = cert_data/n13/h13c.vec.part0587, entries 56627298304 .. 56723767295, chunks 13501 .. 13523
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v587 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0587" 385875968 16777216

end CS31aData.N13
