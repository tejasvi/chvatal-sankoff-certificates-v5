import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1237 = cert_data/n13/h13c.vec.part1237, entries 119332143104 .. 119428612095, chunks 28451 .. 28473
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1237 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1237" 385875968 16777216

end CS31aData.N13
