import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 141 = cert_data/n13/h13c.low.part0141, entries 18333302784 .. 18463326207, chunks 4371 .. 4401
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l141 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0141" 390070272 12582912

end CS31aData.N13
