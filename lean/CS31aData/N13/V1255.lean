import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1255 = cert_data/n13/h13c.vec.part1255, entries 121068584960 .. 121165053951, chunks 28865 .. 28887
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1255 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1255" 385875968 16777216

end CS31aData.N13
