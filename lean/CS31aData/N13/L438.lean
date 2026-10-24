import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 438 = cert_data/n13/h13c.low.part0438, entries 56950259712 .. 57080283135, chunks 13578 .. 13608
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l438 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0438" 390070272 12582912

end CS31aData.N13
