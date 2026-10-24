import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 790 = cert_data/n13/h13c.low.part0790, entries 102718504960 .. 102848528383, chunks 24490 .. 24520
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l790 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0790" 390070272 12582912

end CS31aData.N13
