import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 974 = cert_data/n13/h13c.low.part0974, entries 126642814976 .. 126772838399, chunks 30194 .. 30224
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l974 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0974" 390070272 12582912

end CS31aData.N13
