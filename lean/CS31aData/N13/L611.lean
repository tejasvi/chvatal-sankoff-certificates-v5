import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 611 = cert_data/n13/h13c.low.part0611, entries 79444312064 .. 79574335487, chunks 18941 .. 18971
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l611 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0611" 390070272 12582912

end CS31aData.N13
