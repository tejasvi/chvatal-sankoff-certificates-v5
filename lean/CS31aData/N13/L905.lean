import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 905 = cert_data/n13/h13c.low.part0905, entries 117671198720 .. 117801222143, chunks 28055 .. 28085
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l905 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0905" 390070272 12582912

end CS31aData.N13
