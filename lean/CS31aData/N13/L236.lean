import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 236 = cert_data/n13/h13c.low.part0236, entries 30685528064 .. 30815551487, chunks 7316 .. 7346
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l236 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0236" 390070272 12582912

end CS31aData.N13
