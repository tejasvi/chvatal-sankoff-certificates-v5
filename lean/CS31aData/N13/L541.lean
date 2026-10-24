import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 541 = cert_data/n13/h13c.low.part0541, entries 70342672384 .. 70472695807, chunks 16771 .. 16801
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l541 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0541" 390070272 12582912

end CS31aData.N13
