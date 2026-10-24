import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1029 = cert_data/n13/h13c.low.part1029, entries 133794103296 .. 133924126719, chunks 31899 .. 31929
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1029 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1029" 390070272 12582912

end CS31aData.N13
