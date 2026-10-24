import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 637 = cert_data/n13/h13c.low.part0637, entries 82824921088 .. 82954944511, chunks 19747 .. 19777
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l637 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0637" 390070272 12582912

end CS31aData.N13
