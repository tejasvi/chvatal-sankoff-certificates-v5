import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 237 = cert_data/n13/h13c.low.part0237, entries 30815551488 .. 30945574911, chunks 7347 .. 7377
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l237 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0237" 390070272 12582912

end CS31aData.N13
