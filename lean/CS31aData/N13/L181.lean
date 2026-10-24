import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 181 = cert_data/n13/h13c.low.part0181, entries 23534239744 .. 23664263167, chunks 5611 .. 5641
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l181 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0181" 390070272 12582912

end CS31aData.N13
