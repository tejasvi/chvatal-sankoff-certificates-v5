import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 893 = cert_data/n13/h13c.low.part0893, entries 116110917632 .. 116240941055, chunks 27683 .. 27713
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l893 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0893" 390070272 12582912

end CS31aData.N13
