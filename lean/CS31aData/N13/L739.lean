import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 739 = cert_data/n13/h13c.low.part0739, entries 96087310336 .. 96217333759, chunks 22909 .. 22939
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l739 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0739" 390070272 12582912

end CS31aData.N13
