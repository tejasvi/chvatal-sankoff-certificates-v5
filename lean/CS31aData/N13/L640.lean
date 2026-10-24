import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 640 = cert_data/n13/h13c.low.part0640, entries 83214991360 .. 83345014783, chunks 19840 .. 19870
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l640 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0640" 390070272 12582912

end CS31aData.N13
