import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 63 = cert_data/n13/h13c.low.part0063, entries 8191475712 .. 8321499135, chunks 1953 .. 1983
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l63 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0063" 390070272 12582912

end CS31aData.N13
