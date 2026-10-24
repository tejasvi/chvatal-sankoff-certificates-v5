import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 789 = cert_data/n13/h13c.low.part0789, entries 102588481536 .. 102718504959, chunks 24459 .. 24489
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l789 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0789" 390070272 12582912

end CS31aData.N13
