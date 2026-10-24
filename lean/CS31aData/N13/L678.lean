import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 678 = cert_data/n13/h13c.low.part0678, entries 88155881472 .. 88285904895, chunks 21018 .. 21048
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l678 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0678" 390070272 12582912

end CS31aData.N13
