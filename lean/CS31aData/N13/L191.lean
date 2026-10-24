import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 191 = cert_data/n13/h13c.low.part0191, entries 24834473984 .. 24964497407, chunks 5921 .. 5951
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l191 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0191" 390070272 12582912

end CS31aData.N13
