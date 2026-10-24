import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1357 = cert_data/n13/h13c.vec.part1357, entries 130908422144 .. 131004891135, chunks 31211 .. 31233
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1357 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1357" 385875968 16777216

end CS31aData.N13
