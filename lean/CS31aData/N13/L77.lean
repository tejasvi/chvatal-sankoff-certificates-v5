import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 77 = cert_data/n13/h13c.low.part0077, entries 10011803648 .. 10141827071, chunks 2387 .. 2417
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l77 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0077" 390070272 12582912

end CS31aData.N13
