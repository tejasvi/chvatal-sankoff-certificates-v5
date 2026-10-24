import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 623 = cert_data/n13/h13c.low.part0623, entries 81004593152 .. 81134616575, chunks 19313 .. 19343
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l623 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0623" 390070272 12582912

end CS31aData.N13
