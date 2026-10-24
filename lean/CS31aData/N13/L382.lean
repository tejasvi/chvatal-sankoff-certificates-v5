import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 382 = cert_data/n13/h13c.low.part0382, entries 49668947968 .. 49798971391, chunks 11842 .. 11872
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l382 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0382" 390070272 12582912

end CS31aData.N13
