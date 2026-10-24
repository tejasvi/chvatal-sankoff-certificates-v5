import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 985 = cert_data/n13/h13c.low.part0985, entries 128073072640 .. 128203096063, chunks 30535 .. 30565
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l985 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0985" 390070272 12582912

end CS31aData.N13
