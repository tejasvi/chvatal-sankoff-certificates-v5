import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 890 = cert_data/n13/h13c.low.part0890, entries 115720847360 .. 115850870783, chunks 27590 .. 27620
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l890 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0890" 390070272 12582912

end CS31aData.N13
