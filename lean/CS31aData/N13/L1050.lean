import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1050 = cert_data/n13/h13c.low.part1050, entries 136524595200 .. 136654618623, chunks 32550 .. 32580
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1050 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1050" 390070272 12582912

end CS31aData.N13
