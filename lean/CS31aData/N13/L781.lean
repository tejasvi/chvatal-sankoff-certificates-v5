import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 781 = cert_data/n13/h13c.low.part0781, entries 101548294144 .. 101678317567, chunks 24211 .. 24241
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l781 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0781" 390070272 12582912

end CS31aData.N13
