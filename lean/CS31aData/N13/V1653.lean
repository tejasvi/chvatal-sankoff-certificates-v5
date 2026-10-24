import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1653 = cert_data/n13/h13c.vec.part1653, entries 159463243776 .. 159559712767, chunks 38019 .. 38041
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1653 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1653" 385875968 16777216

end CS31aData.N13
