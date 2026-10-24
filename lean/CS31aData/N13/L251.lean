import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 251 = cert_data/n13/h13c.low.part0251, entries 32635879424 .. 32765902847, chunks 7781 .. 7811
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l251 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0251" 390070272 12582912

end CS31aData.N13
