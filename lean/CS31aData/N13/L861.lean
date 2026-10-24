import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 861 = cert_data/n13/h13c.low.part0861, entries 111950168064 .. 112080191487, chunks 26691 .. 26721
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l861 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0861" 390070272 12582912

end CS31aData.N13
