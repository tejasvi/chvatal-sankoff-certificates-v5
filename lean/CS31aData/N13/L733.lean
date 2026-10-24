import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 733 = cert_data/n13/h13c.low.part0733, entries 95307169792 .. 95437193215, chunks 22723 .. 22753
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l733 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0733" 390070272 12582912

end CS31aData.N13
