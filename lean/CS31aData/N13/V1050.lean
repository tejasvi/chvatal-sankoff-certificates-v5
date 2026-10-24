import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1050 = cert_data/n13/h13c.vec.part1050, entries 101292441600 .. 101388910591, chunks 24150 .. 24172
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1050 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1050" 385875968 16777216

end CS31aData.N13
