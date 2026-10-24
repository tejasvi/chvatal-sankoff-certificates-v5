import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 272 = cert_data/n13/h13c.low.part0272, entries 35366371328 .. 35496394751, chunks 8432 .. 8462
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l272 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0272" 390070272 12582912

end CS31aData.N13
