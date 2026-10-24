import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 428 = cert_data/n13/h13c.low.part0428, entries 55650025472 .. 55780048895, chunks 13268 .. 13298
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l428 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0428" 390070272 12582912

end CS31aData.N13
