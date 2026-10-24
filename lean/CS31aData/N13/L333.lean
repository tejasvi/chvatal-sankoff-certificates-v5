import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 333 = cert_data/n13/h13c.low.part0333, entries 43297800192 .. 43427823615, chunks 10323 .. 10353
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l333 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0333" 390070272 12582912

end CS31aData.N13
