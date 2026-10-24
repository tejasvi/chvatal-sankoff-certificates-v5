import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 178 = cert_data/n13/h13c.low.part0178, entries 23144169472 .. 23274192895, chunks 5518 .. 5548
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l178 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0178" 390070272 12582912

end CS31aData.N13
