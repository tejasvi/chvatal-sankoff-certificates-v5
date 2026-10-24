import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 569 = cert_data/n13/h13c.low.part0569, entries 73983328256 .. 74113351679, chunks 17639 .. 17669
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l569 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0569" 390070272 12582912

end CS31aData.N13
