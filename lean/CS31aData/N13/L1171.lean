import CS31aData.Elab

/-! N13 data, low (key mod 2^20, 3 bytes LE per entry): part 1171 = cert_data/n13/h13c.low.part1171, entries 152257429504 .. 152387452927, chunks 36301 .. 36331
of 2^22 entries (12582912 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def l1171 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.low.part1171" 390070272 12582912

end CS31aData.N13
