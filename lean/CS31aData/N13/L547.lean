import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 547 = cert_data/n13/h13c.low.part0547, entries 71122812928 .. 71252836351, chunks 16957 .. 16987
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l547 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0547" 390070272 12582912

end CS31aData.N13
