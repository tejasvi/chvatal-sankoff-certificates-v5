import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1024 = cert_data/n13/h13c.low.part1024, entries 133143986176 .. 133274009599, chunks 31744 .. 31774
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1024 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1024" 390070272 12582912

end CS31aData.N13
