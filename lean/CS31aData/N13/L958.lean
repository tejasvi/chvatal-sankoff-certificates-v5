import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 958 = cert_data/n13/h13c.low.part0958, entries 124562440192 .. 124692463615, chunks 29698 .. 29728
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l958 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0958" 390070272 12582912

end CS31aData.N13
