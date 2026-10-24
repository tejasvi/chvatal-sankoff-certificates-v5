import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 477 = cert_data/n13/h13c.low.part0477, entries 62021173248 .. 62151196671, chunks 14787 .. 14817
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l477 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0477" 390070272 12582912

end CS31aData.N13
