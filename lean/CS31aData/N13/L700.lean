import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 700 = cert_data/n13/h13c.low.part0700, entries 91016396800 .. 91146420223, chunks 21700 .. 21730
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l700 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0700" 390070272 12582912

end CS31aData.N13
