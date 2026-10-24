import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 813 = cert_data/n13/h13c.low.part0813, entries 105709043712 .. 105839067135, chunks 25203 .. 25233
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l813 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0813" 390070272 12582912

end CS31aData.N13
