import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 772 = cert_data/n13/h13c.low.part0772, entries 100378083328 .. 100508106751, chunks 23932 .. 23962
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l772 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0772" 390070272 12582912

end CS31aData.N13
