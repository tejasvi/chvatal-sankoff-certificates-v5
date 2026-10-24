import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 130 = cert_data/n13/h13c.low.part0130, entries 16903045120 .. 17033068543, chunks 4030 .. 4060
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l130 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0130" 390070272 12582912

end CS31aData.N13
