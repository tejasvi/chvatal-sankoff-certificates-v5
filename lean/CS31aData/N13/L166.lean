import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 166 = cert_data/n13/h13c.low.part0166, entries 21583888384 .. 21713911807, chunks 5146 .. 5176
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l166 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0166" 390070272 12582912

end CS31aData.N13
