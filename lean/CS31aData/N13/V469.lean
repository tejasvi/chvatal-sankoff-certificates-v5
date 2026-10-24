import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 469 = cert_data/n13/h13c.vec.part0469, entries 45243957248 .. 45340426239, chunks 10787 .. 10809
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v469 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0469" 385875968 16777216

end CS31aData.N13
