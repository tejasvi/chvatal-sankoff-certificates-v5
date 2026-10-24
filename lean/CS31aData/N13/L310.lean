import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 310 = cert_data/n13/h13c.low.part0310, entries 40307261440 .. 40437284863, chunks 9610 .. 9640
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l310 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0310" 390070272 12582912

end CS31aData.N13
