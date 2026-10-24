import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 657 = cert_data/n13/h13c.low.part0657, entries 85425389568 .. 85555412991, chunks 20367 .. 20397
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l657 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0657" 390070272 12582912

end CS31aData.N13
