import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 336 = cert_data/n13/h13c.low.part0336, entries 43687870464 .. 43817893887, chunks 10416 .. 10446
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l336 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0336" 390070272 12582912

end CS31aData.N13
