import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 80 = cert_data/n13/h13c.low.part0080, entries 10401873920 .. 10531897343, chunks 2480 .. 2510
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l80 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0080" 390070272 12582912

end CS31aData.N13
