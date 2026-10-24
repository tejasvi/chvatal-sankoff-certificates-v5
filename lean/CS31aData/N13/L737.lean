import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 737 = cert_data/n13/h13c.low.part0737, entries 95827263488 .. 95957286911, chunks 22847 .. 22877
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l737 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0737" 390070272 12582912

end CS31aData.N13
