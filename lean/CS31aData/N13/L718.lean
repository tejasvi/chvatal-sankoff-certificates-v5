import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 718 = cert_data/n13/h13c.low.part0718, entries 93356818432 .. 93486841855, chunks 22258 .. 22288
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l718 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0718" 390070272 12582912

end CS31aData.N13
