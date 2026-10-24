import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 404 = cert_data/n13/h13c.low.part0404, entries 52529463296 .. 52659486719, chunks 12524 .. 12554
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l404 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0404" 390070272 12582912

end CS31aData.N13
