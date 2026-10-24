import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 639 = cert_data/n13/h13c.low.part0639, entries 83084967936 .. 83214991359, chunks 19809 .. 19839
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l639 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0639" 390070272 12582912

end CS31aData.N13
