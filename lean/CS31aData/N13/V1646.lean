import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1646 = cert_data/n13/h13c.vec.part1646, entries 158787960832 .. 158884429823, chunks 37858 .. 37880
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1646 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1646" 385875968 16777216

end CS31aData.N13
