import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 371 = cert_data/n13/h13c.low.part0371, entries 48238690304 .. 48368713727, chunks 11501 .. 11531
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l371 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0371" 390070272 12582912

end CS31aData.N13
