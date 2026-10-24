import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 261 = cert_data/n13/h13c.low.part0261, entries 33936113664 .. 34066137087, chunks 8091 .. 8121
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l261 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0261" 390070272 12582912

end CS31aData.N13
