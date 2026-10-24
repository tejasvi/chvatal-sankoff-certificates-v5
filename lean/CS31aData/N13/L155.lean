import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 155 = cert_data/n13/h13c.low.part0155, entries 20153630720 .. 20283654143, chunks 4805 .. 4835
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l155 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0155" 390070272 12582912

end CS31aData.N13
