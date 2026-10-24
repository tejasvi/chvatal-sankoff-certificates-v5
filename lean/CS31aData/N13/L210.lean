import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 210 = cert_data/n13/h13c.low.part0210, entries 27304919040 .. 27434942463, chunks 6510 .. 6540
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l210 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0210" 390070272 12582912

end CS31aData.N13
