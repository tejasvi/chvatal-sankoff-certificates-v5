import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 688 = cert_data/n13/h13c.low.part0688, entries 89456115712 .. 89586139135, chunks 21328 .. 21358
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l688 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0688" 390070272 12582912

end CS31aData.N13
