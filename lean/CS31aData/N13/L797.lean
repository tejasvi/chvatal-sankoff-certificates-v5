import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 797 = cert_data/n13/h13c.low.part0797, entries 103628668928 .. 103758692351, chunks 24707 .. 24737
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l797 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0797" 390070272 12582912

end CS31aData.N13
