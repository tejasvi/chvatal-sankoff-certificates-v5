import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 205 = cert_data/n13/h13c.low.part0205, entries 26654801920 .. 26784825343, chunks 6355 .. 6385
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l205 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0205" 390070272 12582912

end CS31aData.N13
