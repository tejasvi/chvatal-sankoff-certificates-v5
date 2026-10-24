import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 445 = cert_data/n13/h13c.low.part0445, entries 57860423680 .. 57990447103, chunks 13795 .. 13825
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l445 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0445" 390070272 12582912

end CS31aData.N13
