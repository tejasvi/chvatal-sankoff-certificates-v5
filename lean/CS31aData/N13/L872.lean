import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 872 = cert_data/n13/h13c.low.part0872, entries 113380425728 .. 113510449151, chunks 27032 .. 27062
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l872 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0872" 390070272 12582912

end CS31aData.N13
