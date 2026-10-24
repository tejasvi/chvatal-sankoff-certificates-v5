import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 603 = cert_data/n13/h13c.low.part0603, entries 78404124672 .. 78534148095, chunks 18693 .. 18723
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l603 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0603" 390070272 12582912

end CS31aData.N13
