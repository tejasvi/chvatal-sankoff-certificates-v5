import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 761 = cert_data/n13/h13c.low.part0761, entries 98947825664 .. 99077849087, chunks 23591 .. 23621
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l761 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0761" 390070272 12582912

end CS31aData.N13
