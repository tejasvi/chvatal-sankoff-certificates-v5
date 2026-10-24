import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 977 = cert_data/n13/h13c.low.part0977, entries 127032885248 .. 127162908671, chunks 30287 .. 30317
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l977 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0977" 390070272 12582912

end CS31aData.N13
