import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1189 = cert_data/n13/h13c.vec.part1189, entries 114701631488 .. 114798100479, chunks 27347 .. 27369
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1189 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1189" 385875968 16777216

end CS31aData.N13
