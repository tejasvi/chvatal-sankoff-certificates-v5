import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 363 = cert_data/n13/h13c.low.part0363, entries 47198502912 .. 47328526335, chunks 11253 .. 11283
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l363 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0363" 390070272 12582912

end CS31aData.N13
