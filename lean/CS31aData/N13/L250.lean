import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 250 = cert_data/n13/h13c.low.part0250, entries 32505856000 .. 32635879423, chunks 7750 .. 7780
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l250 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0250" 390070272 12582912

end CS31aData.N13
