import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1397 = cert_data/n13/h13c.vec.part1397, entries 134767181824 .. 134863650815, chunks 32131 .. 32153
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1397 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1397" 385875968 16777216

end CS31aData.N13
