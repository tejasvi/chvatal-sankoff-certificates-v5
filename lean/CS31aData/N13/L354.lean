import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 354 = cert_data/n13/h13c.low.part0354, entries 46028292096 .. 46158315519, chunks 10974 .. 11004
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l354 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0354" 390070272 12582912

end CS31aData.N13
