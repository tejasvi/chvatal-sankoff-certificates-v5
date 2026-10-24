import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 682 = cert_data/n13/h13c.low.part0682, entries 88675975168 .. 88805998591, chunks 21142 .. 21172
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l682 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0682" 390070272 12582912

end CS31aData.N13
