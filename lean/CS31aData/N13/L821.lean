import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 821 = cert_data/n13/h13c.low.part0821, entries 106749231104 .. 106879254527, chunks 25451 .. 25481
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l821 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0821" 390070272 12582912

end CS31aData.N13
