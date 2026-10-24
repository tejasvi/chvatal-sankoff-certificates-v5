import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 726 = cert_data/n13/h13c.low.part0726, entries 94397005824 .. 94527029247, chunks 22506 .. 22536
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l726 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0726" 390070272 12582912

end CS31aData.N13
