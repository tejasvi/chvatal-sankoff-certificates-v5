import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 802 = cert_data/n13/h13c.low.part0802, entries 104278786048 .. 104408809471, chunks 24862 .. 24892
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l802 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0802" 390070272 12582912

end CS31aData.N13
