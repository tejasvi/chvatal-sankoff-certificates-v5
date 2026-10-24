import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 431 = cert_data/n13/h13c.low.part0431, entries 56040095744 .. 56170119167, chunks 13361 .. 13391
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l431 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0431" 390070272 12582912

end CS31aData.N13
