import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 463 = cert_data/n13/h13c.low.part0463, entries 60200845312 .. 60330868735, chunks 14353 .. 14383
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l463 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0463" 390070272 12582912

end CS31aData.N13
