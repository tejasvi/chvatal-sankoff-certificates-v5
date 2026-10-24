import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1212 = cert_data/n13/h13c.vec.part1212, entries 116920418304 .. 117016887295, chunks 27876 .. 27898
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1212 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1212" 385875968 16777216

end CS31aData.N13
