import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 507 = cert_data/n13/h13c.low.part0507, entries 65921875968 .. 66051899391, chunks 15717 .. 15747
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l507 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0507" 390070272 12582912

end CS31aData.N13
