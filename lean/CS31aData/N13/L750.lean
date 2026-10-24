import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 750 = cert_data/n13/h13c.low.part0750, entries 97517568000 .. 97647591423, chunks 23250 .. 23280
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l750 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0750" 390070272 12582912

end CS31aData.N13
