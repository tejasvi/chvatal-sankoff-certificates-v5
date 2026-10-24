import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 374 = cert_data/n13/h13c.low.part0374, entries 48628760576 .. 48758783999, chunks 11594 .. 11624
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l374 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0374" 390070272 12582912

end CS31aData.N13
