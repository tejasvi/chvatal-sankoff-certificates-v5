import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 575 = cert_data/n13/h13c.low.part0575, entries 74763468800 .. 74893492223, chunks 17825 .. 17855
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l575 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0575" 390070272 12582912

end CS31aData.N13
