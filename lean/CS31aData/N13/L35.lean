import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 35 = cert_data/n13/h13c.low.part0035, entries 4550819840 .. 4680843263, chunks 1085 .. 1115
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l35 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0035" 390070272 12582912

end CS31aData.N13
