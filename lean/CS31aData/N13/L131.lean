import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 131 = cert_data/n13/h13c.low.part0131, entries 17033068544 .. 17163091967, chunks 4061 .. 4091
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l131 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0131" 390070272 12582912

end CS31aData.N13
