import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 499 = cert_data/n13/h13c.low.part0499, entries 64881688576 .. 65011711999, chunks 15469 .. 15499
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l499 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0499" 390070272 12582912

end CS31aData.N13
