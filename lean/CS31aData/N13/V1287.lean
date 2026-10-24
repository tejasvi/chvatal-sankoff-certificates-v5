import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1287 = cert_data/n13/h13c.vec.part1287, entries 124155592704 .. 124252061695, chunks 29601 .. 29623
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1287 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1287" 385875968 16777216

end CS31aData.N13
