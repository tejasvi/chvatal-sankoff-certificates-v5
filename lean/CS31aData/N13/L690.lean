import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 690 = cert_data/n13/h13c.low.part0690, entries 89716162560 .. 89846185983, chunks 21390 .. 21420
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l690 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0690" 390070272 12582912

end CS31aData.N13
