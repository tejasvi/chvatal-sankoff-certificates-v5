import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 239 = cert_data/n13/h13c.low.part0239, entries 31075598336 .. 31205621759, chunks 7409 .. 7439
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l239 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0239" 390070272 12582912

end CS31aData.N13
