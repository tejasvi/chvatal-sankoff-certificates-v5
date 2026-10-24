import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 530 = cert_data/n13/h13c.low.part0530, entries 68912414720 .. 69042438143, chunks 16430 .. 16460
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l530 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0530" 390070272 12582912

end CS31aData.N13
