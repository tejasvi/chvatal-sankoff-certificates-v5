import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 869 = cert_data/n13/h13c.low.part0869, entries 112990355456 .. 113120378879, chunks 26939 .. 26969
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l869 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0869" 390070272 12582912

end CS31aData.N13
