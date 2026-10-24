import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 464 = cert_data/n13/h13c.low.part0464, entries 60330868736 .. 60460892159, chunks 14384 .. 14414
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l464 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0464" 390070272 12582912

end CS31aData.N13
