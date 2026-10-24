import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 764 = cert_data/n13/h13c.low.part0764, entries 99337895936 .. 99467919359, chunks 23684 .. 23714
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l764 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0764" 390070272 12582912

end CS31aData.N13
