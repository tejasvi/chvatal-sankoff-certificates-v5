import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 193 = cert_data/n13/h13c.low.part0193, entries 25094520832 .. 25224544255, chunks 5983 .. 6013
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l193 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0193" 390070272 12582912

end CS31aData.N13
