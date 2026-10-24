import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 961 = cert_data/n13/h13c.low.part0961, entries 124952510464 .. 125082533887, chunks 29791 .. 29821
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l961 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0961" 390070272 12582912

end CS31aData.N13
