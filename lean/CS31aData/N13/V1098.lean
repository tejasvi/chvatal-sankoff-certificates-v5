import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1098 = cert_data/n13/h13c.vec.part1098, entries 105922953216 .. 106019422207, chunks 25254 .. 25276
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1098 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1098" 385875968 16777216

end CS31aData.N13
