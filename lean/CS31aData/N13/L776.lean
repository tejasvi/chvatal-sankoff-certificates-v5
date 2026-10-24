import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 776 = cert_data/n13/h13c.low.part0776, entries 100898177024 .. 101028200447, chunks 24056 .. 24086
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l776 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0776" 390070272 12582912

end CS31aData.N13
