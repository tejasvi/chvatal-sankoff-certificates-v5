import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1693 = cert_data/n13/h13c.vec.part1693, entries 163322003456 .. 163418472447, chunks 38939 .. 38961
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1693 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1693" 385875968 16777216

end CS31aData.N13
