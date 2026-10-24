import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 641 = cert_data/n13/h13c.low.part0641, entries 83345014784 .. 83475038207, chunks 19871 .. 19901
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l641 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0641" 390070272 12582912

end CS31aData.N13
