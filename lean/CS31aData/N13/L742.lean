import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 742 = cert_data/n13/h13c.low.part0742, entries 96477380608 .. 96607404031, chunks 23002 .. 23032
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l742 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0742" 390070272 12582912

end CS31aData.N13
