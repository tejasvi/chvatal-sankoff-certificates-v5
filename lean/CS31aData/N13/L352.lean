import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 352 = cert_data/n13/h13c.low.part0352, entries 45768245248 .. 45898268671, chunks 10912 .. 10942
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l352 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0352" 390070272 12582912

end CS31aData.N13
