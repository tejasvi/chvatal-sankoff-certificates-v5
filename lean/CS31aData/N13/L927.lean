import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 927 = cert_data/n13/h13c.low.part0927, entries 120531714048 .. 120661737471, chunks 28737 .. 28767
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l927 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0927" 390070272 12582912

end CS31aData.N13
