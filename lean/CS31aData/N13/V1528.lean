import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1528 = cert_data/n13/h13c.vec.part1528, entries 147404619776 .. 147501088767, chunks 35144 .. 35166
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1528 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1528" 385875968 16777216

end CS31aData.N13
