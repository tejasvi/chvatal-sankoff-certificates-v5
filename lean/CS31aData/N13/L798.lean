import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 798 = cert_data/n13/h13c.low.part0798, entries 103758692352 .. 103888715775, chunks 24738 .. 24768
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l798 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0798" 390070272 12582912

end CS31aData.N13
