import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 227 = cert_data/n13/h13c.low.part0227, entries 29515317248 .. 29645340671, chunks 7037 .. 7067
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l227 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0227" 390070272 12582912

end CS31aData.N13
