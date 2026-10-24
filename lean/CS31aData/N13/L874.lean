import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 874 = cert_data/n13/h13c.low.part0874, entries 113640472576 .. 113770495999, chunks 27094 .. 27124
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l874 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0874" 390070272 12582912

end CS31aData.N13
