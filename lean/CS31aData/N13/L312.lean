import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 312 = cert_data/n13/h13c.low.part0312, entries 40567308288 .. 40697331711, chunks 9672 .. 9702
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l312 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0312" 390070272 12582912

end CS31aData.N13
