import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 615 = cert_data/n13/h13c.low.part0615, entries 79964405760 .. 80094429183, chunks 19065 .. 19095
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l615 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0615" 390070272 12582912

end CS31aData.N13
