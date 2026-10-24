import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 221 = cert_data/n13/h13c.low.part0221, entries 28735176704 .. 28865200127, chunks 6851 .. 6881
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l221 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0221" 390070272 12582912

end CS31aData.N13
