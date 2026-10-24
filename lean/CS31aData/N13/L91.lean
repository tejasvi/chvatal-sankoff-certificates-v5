import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 91 = cert_data/n13/h13c.low.part0091, entries 11832131584 .. 11962155007, chunks 2821 .. 2851
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l91 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0091" 390070272 12582912

end CS31aData.N13
