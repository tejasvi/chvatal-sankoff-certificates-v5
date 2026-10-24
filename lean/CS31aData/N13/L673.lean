import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 673 = cert_data/n13/h13c.low.part0673, entries 87505764352 .. 87635787775, chunks 20863 .. 20893
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l673 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0673" 390070272 12582912

end CS31aData.N13
