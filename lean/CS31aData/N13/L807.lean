import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 807 = cert_data/n13/h13c.low.part0807, entries 104928903168 .. 105058926591, chunks 25017 .. 25047
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l807 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0807" 390070272 12582912

end CS31aData.N13
