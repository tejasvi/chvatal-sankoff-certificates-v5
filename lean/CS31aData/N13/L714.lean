import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 714 = cert_data/n13/h13c.low.part0714, entries 92836724736 .. 92966748159, chunks 22134 .. 22164
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l714 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0714" 390070272 12582912

end CS31aData.N13
