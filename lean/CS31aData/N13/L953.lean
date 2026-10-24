import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 953 = cert_data/n13/h13c.low.part0953, entries 123912323072 .. 124042346495, chunks 29543 .. 29573
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l953 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0953" 390070272 12582912

end CS31aData.N13
