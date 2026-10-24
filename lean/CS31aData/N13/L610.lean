import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 610 = cert_data/n13/h13c.low.part0610, entries 79314288640 .. 79444312063, chunks 18910 .. 18940
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l610 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0610" 390070272 12582912

end CS31aData.N13
