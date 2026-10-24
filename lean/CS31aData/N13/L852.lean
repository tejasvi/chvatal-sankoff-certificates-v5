import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 852 = cert_data/n13/h13c.low.part0852, entries 110779957248 .. 110909980671, chunks 26412 .. 26442
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l852 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0852" 390070272 12582912

end CS31aData.N13
