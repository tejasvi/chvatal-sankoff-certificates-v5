import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 949 = cert_data/n13/h13c.low.part0949, entries 123392229376 .. 123522252799, chunks 29419 .. 29449
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l949 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0949" 390070272 12582912

end CS31aData.N13
