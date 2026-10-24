import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 941 = cert_data/n13/h13c.low.part0941, entries 122352041984 .. 122482065407, chunks 29171 .. 29201
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l941 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0941" 390070272 12582912

end CS31aData.N13
