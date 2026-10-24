import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 456 = cert_data/n13/h13c.low.part0456, entries 59290681344 .. 59420704767, chunks 14136 .. 14166
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l456 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0456" 390070272 12582912

end CS31aData.N13
