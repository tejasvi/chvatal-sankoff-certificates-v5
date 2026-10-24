import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 425 = cert_data/n13/h13c.low.part0425, entries 55259955200 .. 55389978623, chunks 13175 .. 13205
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l425 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0425" 390070272 12582912

end CS31aData.N13
