import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 943 = cert_data/n13/h13c.low.part0943, entries 122612088832 .. 122742112255, chunks 29233 .. 29263
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l943 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0943" 390070272 12582912

end CS31aData.N13
