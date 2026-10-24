import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1070 = cert_data/n13/h13c.low.part1070, entries 139125063680 .. 139255087103, chunks 33170 .. 33200
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1070 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1070" 390070272 12582912

end CS31aData.N13
