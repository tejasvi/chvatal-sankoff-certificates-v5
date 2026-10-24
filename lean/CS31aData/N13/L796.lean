import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 796 = cert_data/n13/h13c.low.part0796, entries 103498645504 .. 103628668927, chunks 24676 .. 24706
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l796 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0796" 390070272 12582912

end CS31aData.N13
