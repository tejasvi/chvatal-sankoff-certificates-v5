import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 183 = cert_data/n13/h13c.low.part0183, entries 23794286592 .. 23924310015, chunks 5673 .. 5703
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l183 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0183" 390070272 12582912

end CS31aData.N13
