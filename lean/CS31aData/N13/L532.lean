import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 532 = cert_data/n13/h13c.low.part0532, entries 69172461568 .. 69302484991, chunks 16492 .. 16522
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l532 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0532" 390070272 12582912

end CS31aData.N13
