import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 138 = cert_data/n13/h13c.low.part0138, entries 17943232512 .. 18073255935, chunks 4278 .. 4308
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l138 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0138" 390070272 12582912

end CS31aData.N13
