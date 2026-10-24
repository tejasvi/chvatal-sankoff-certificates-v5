import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 287 = cert_data/n13/h13c.low.part0287, entries 37316722688 .. 37446746111, chunks 8897 .. 8927
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l287 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0287" 390070272 12582912

end CS31aData.N13
