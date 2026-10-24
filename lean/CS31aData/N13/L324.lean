import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 324 = cert_data/n13/h13c.low.part0324, entries 42127589376 .. 42257612799, chunks 10044 .. 10074
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l324 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0324" 390070272 12582912

end CS31aData.N13
