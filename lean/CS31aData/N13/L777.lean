import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 777 = cert_data/n13/h13c.low.part0777, entries 101028200448 .. 101158223871, chunks 24087 .. 24117
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l777 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0777" 390070272 12582912

end CS31aData.N13
