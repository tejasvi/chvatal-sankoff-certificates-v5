import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 937 = cert_data/n13/h13c.low.part0937, entries 121831948288 .. 121961971711, chunks 29047 .. 29077
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l937 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0937" 390070272 12582912

end CS31aData.N13
