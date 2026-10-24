import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 416 = cert_data/n13/h13c.low.part0416, entries 54089744384 .. 54219767807, chunks 12896 .. 12926
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l416 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0416" 390070272 12582912

end CS31aData.N13
