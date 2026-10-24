import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1652 = cert_data/n13/h13c.vec.part1652, entries 159366774784 .. 159463243775, chunks 37996 .. 38018
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1652 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1652" 385875968 16777216

end CS31aData.N13
