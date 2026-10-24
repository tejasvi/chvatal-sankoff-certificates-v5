import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 879 = cert_data/n13/h13c.low.part0879, entries 114290589696 .. 114420613119, chunks 27249 .. 27279
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l879 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part0879" 390070272 12582912

end CS31aData.N13
