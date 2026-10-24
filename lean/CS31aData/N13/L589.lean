import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 589 = cert_data/n13/h13c.low.part0589, entries 76583796736 .. 76713820159, chunks 18259 .. 18289
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l589 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0589" 390070272 12582912

end CS31aData.N13
