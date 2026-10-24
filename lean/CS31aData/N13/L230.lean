import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 230 = cert_data/n13/h13c.low.part0230, entries 29905387520 .. 30035410943, chunks 7130 .. 7160
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l230 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0230" 390070272 12582912

end CS31aData.N13
