import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 245 = cert_data/n13/h13c.low.part0245, entries 31855738880 .. 31985762303, chunks 7595 .. 7625
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l245 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0245" 390070272 12582912

end CS31aData.N13
