import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 220 = cert_data/n13/h13c.low.part0220, entries 28605153280 .. 28735176703, chunks 6820 .. 6850
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l220 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0220" 390070272 12582912

end CS31aData.N13
