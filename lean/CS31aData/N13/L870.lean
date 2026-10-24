import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 870 = cert_data/n13/h13c.low.part0870, entries 113120378880 .. 113250402303, chunks 26970 .. 27000
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l870 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0870" 390070272 12582912

end CS31aData.N13
