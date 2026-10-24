import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 825 = cert_data/n13/h13c.low.part0825, entries 107269324800 .. 107399348223, chunks 25575 .. 25605
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l825 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0825" 390070272 12582912

end CS31aData.N13
