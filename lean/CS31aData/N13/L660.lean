import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 660 = cert_data/n13/h13c.low.part0660, entries 85815459840 .. 85945483263, chunks 20460 .. 20490
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l660 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0660" 390070272 12582912

end CS31aData.N13
