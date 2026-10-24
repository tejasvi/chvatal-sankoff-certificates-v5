import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 417 = cert_data/n13/h13c.low.part0417, entries 54219767808 .. 54349791231, chunks 12927 .. 12957
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l417 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0417" 390070272 12582912

end CS31aData.N13
