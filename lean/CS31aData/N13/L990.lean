import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 990 = cert_data/n13/h13c.low.part0990, entries 128723189760 .. 128853213183, chunks 30690 .. 30720
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l990 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0990" 390070272 12582912

end CS31aData.N13
