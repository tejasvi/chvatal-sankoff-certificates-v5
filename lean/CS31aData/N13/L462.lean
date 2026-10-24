import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 462 = cert_data/n13/h13c.low.part0462, entries 60070821888 .. 60200845311, chunks 14322 .. 14352
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l462 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0462" 390070272 12582912

end CS31aData.N13
