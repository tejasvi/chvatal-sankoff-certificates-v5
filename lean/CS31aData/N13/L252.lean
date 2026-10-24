import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 252 = cert_data/n13/h13c.low.part0252, entries 32765902848 .. 32895926271, chunks 7812 .. 7842
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l252 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0252" 390070272 12582912

end CS31aData.N13
