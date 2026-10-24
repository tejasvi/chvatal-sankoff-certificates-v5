import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 337 = cert_data/n13/h13c.low.part0337, entries 43817893888 .. 43947917311, chunks 10447 .. 10477
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l337 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0337" 390070272 12582912

end CS31aData.N13
