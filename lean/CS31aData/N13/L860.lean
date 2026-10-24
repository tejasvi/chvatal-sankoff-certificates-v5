import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 860 = cert_data/n13/h13c.low.part0860, entries 111820144640 .. 111950168063, chunks 26660 .. 26690
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l860 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0860" 390070272 12582912

end CS31aData.N13
