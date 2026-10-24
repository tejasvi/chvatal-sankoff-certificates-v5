import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 502 = cert_data/n13/h13c.low.part0502, entries 65271758848 .. 65401782271, chunks 15562 .. 15592
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l502 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0502" 390070272 12582912

end CS31aData.N13
