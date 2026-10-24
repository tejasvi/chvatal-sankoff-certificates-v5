import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 485 = cert_data/n13/h13c.low.part0485, entries 63061360640 .. 63191384063, chunks 15035 .. 15065
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l485 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0485" 390070272 12582912

end CS31aData.N13
