import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 151 = cert_data/n13/h13c.low.part0151, entries 19633537024 .. 19763560447, chunks 4681 .. 4711
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l151 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0151" 390070272 12582912

end CS31aData.N13
