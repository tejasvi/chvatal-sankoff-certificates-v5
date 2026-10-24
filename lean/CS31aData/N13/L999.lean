import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 999 = cert_data/n13/h13c.low.part0999, entries 129893400576 .. 130023423999, chunks 30969 .. 30999
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l999 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0999" 390070272 12582912

end CS31aData.N13
