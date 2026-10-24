import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 596 = cert_data/n13/h13c.low.part0596, entries 77493960704 .. 77623984127, chunks 18476 .. 18506
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l596 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0596" 390070272 12582912

end CS31aData.N13
