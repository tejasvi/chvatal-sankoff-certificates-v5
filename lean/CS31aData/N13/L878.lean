import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 878 = cert_data/n13/h13c.low.part0878, entries 114160566272 .. 114290589695, chunks 27218 .. 27248
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l878 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0878" 390070272 12582912

end CS31aData.N13
