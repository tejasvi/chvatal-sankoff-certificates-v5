import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 866 = cert_data/n13/h13c.low.part0866, entries 112600285184 .. 112730308607, chunks 26846 .. 26876
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l866 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0866" 390070272 12582912

end CS31aData.N13
