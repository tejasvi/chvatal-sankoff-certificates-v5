import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 316 = cert_data/n13/h13c.low.part0316, entries 41087401984 .. 41217425407, chunks 9796 .. 9826
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l316 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0316" 390070272 12582912

end CS31aData.N13
