import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1331 = cert_data/n13/h13c.vec.part1331, entries 128400228352 .. 128496697343, chunks 30613 .. 30635
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1331 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1331" 385875968 16777216

end CS31aData.N13
