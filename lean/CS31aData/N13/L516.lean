import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 516 = cert_data/n13/h13c.low.part0516, entries 67092086784 .. 67222110207, chunks 15996 .. 16026
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l516 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0516" 390070272 12582912

end CS31aData.N13
