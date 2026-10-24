import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 873 = cert_data/n13/h13c.low.part0873, entries 113510449152 .. 113640472575, chunks 27063 .. 27093
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l873 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0873" 390070272 12582912

end CS31aData.N13
