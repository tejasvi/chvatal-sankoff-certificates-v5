import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 936 = cert_data/n13/h13c.low.part0936, entries 121701924864 .. 121831948287, chunks 29016 .. 29046
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l936 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0936" 390070272 12582912

end CS31aData.N13
