import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 546 = cert_data/n13/h13c.low.part0546, entries 70992789504 .. 71122812927, chunks 16926 .. 16956
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l546 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0546" 390070272 12582912

end CS31aData.N13
