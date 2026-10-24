import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 397 = cert_data/n13/h13c.low.part0397, entries 51619299328 .. 51749322751, chunks 12307 .. 12337
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l397 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0397" 390070272 12582912

end CS31aData.N13
