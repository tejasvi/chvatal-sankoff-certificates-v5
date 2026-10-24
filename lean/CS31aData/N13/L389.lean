import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 389 = cert_data/n13/h13c.low.part0389, entries 50579111936 .. 50709135359, chunks 12059 .. 12089
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l389 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0389" 390070272 12582912

end CS31aData.N13
