import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 783 = cert_data/n13/h13c.low.part0783, entries 101808340992 .. 101938364415, chunks 24273 .. 24303
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l783 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0783" 390070272 12582912

end CS31aData.N13
