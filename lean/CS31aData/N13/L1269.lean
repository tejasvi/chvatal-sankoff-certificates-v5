import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1269 = cert_data/n13/h13c.low.part1269, entries 164999725056 .. 165129748479, chunks 39339 .. 39369
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1269 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1269" 390070272 12582912

end CS31aData.N13
