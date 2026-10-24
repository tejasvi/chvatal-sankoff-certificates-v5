import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 832 = cert_data/n13/h13c.low.part0832, entries 108179488768 .. 108309512191, chunks 25792 .. 25822
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l832 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0832" 390070272 12582912

end CS31aData.N13
