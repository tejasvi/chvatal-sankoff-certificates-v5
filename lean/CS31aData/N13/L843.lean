import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 843 = cert_data/n13/h13c.low.part0843, entries 109609746432 .. 109739769855, chunks 26133 .. 26163
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l843 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0843" 390070272 12582912

end CS31aData.N13
