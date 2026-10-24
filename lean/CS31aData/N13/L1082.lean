import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1082 = cert_data/n13/h13c.low.part1082, entries 140685344768 .. 140815368191, chunks 33542 .. 33572
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1082 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1082" 390070272 12582912

end CS31aData.N13
