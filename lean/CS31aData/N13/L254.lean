import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 254 = cert_data/n13/h13c.low.part0254, entries 33025949696 .. 33155973119, chunks 7874 .. 7904
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l254 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0254" 390070272 12582912

end CS31aData.N13
