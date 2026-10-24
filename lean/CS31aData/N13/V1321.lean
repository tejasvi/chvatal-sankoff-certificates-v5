import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1321 = cert_data/n13/h13c.vec.part1321, entries 127435538432 .. 127532007423, chunks 30383 .. 30405
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1321 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1321" 385875968 16777216

end CS31aData.N13
