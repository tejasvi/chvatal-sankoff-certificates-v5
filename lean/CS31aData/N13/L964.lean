import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 964 = cert_data/n13/h13c.low.part0964, entries 125342580736 .. 125472604159, chunks 29884 .. 29914
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l964 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0964" 390070272 12582912

end CS31aData.N13
