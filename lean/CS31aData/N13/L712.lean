import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 712 = cert_data/n13/h13c.low.part0712, entries 92576677888 .. 92706701311, chunks 22072 .. 22102
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l712 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0712" 390070272 12582912

end CS31aData.N13
