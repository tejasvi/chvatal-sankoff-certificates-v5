import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 647 = cert_data/n13/h13c.low.part0647, entries 84125155328 .. 84255178751, chunks 20057 .. 20087
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l647 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0647" 390070272 12582912

end CS31aData.N13
