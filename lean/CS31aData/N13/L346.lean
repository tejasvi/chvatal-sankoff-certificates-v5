import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 346 = cert_data/n13/h13c.low.part0346, entries 44988104704 .. 45118128127, chunks 10726 .. 10756
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l346 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0346" 390070272 12582912

end CS31aData.N13
