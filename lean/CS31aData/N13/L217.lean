import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 217 = cert_data/n13/h13c.low.part0217, entries 28215083008 .. 28345106431, chunks 6727 .. 6757
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l217 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0217" 390070272 12582912

end CS31aData.N13
