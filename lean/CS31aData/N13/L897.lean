import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 897 = cert_data/n13/h13c.low.part0897, entries 116631011328 .. 116761034751, chunks 27807 .. 27837
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l897 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0897" 390070272 12582912

end CS31aData.N13
