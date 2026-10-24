import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 535 = cert_data/n13/h13c.low.part0535, entries 69562531840 .. 69692555263, chunks 16585 .. 16615
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l535 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0535" 390070272 12582912

end CS31aData.N13
