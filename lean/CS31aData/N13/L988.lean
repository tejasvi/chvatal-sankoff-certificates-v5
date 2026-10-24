import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 988 = cert_data/n13/h13c.low.part0988, entries 128463142912 .. 128593166335, chunks 30628 .. 30658
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l988 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0988" 390070272 12582912

end CS31aData.N13
