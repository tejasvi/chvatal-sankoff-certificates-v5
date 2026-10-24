import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 214 = cert_data/n13/h13c.low.part0214, entries 27825012736 .. 27955036159, chunks 6634 .. 6664
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l214 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0214" 390070272 12582912

end CS31aData.N13
