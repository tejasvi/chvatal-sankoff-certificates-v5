import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 59 = cert_data/n13/h13c.low.part0059, entries 7671382016 .. 7801405439, chunks 1829 .. 1859
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l59 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0059" 390070272 12582912

end CS31aData.N13
