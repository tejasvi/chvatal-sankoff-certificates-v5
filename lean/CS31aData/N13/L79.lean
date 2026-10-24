import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 79 = cert_data/n13/h13c.low.part0079, entries 10271850496 .. 10401873919, chunks 2449 .. 2479
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l79 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0079" 390070272 12582912

end CS31aData.N13
