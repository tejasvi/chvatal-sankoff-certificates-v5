import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 278 = cert_data/n13/h13c.low.part0278, entries 36146511872 .. 36276535295, chunks 8618 .. 8648
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l278 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0278" 390070272 12582912

end CS31aData.N13
