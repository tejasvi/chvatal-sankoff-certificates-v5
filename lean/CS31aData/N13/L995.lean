import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 995 = cert_data/n13/h13c.low.part0995, entries 129373306880 .. 129503330303, chunks 30845 .. 30875
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l995 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0995" 390070272 12582912

end CS31aData.N13
