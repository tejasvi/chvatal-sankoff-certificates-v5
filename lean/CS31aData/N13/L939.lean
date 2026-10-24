import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 939 = cert_data/n13/h13c.low.part0939, entries 122091995136 .. 122222018559, chunks 29109 .. 29139
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l939 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0939" 390070272 12582912

end CS31aData.N13
