import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 915 = cert_data/n13/h13c.low.part0915, entries 118971432960 .. 119101456383, chunks 28365 .. 28395
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l915 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0915" 390070272 12582912

end CS31aData.N13
