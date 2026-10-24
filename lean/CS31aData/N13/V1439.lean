import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1439 = cert_data/n13/h13c.vec.part1439, entries 138818879488 .. 138915348479, chunks 33097 .. 33119
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1439 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1439" 385875968 16777216

end CS31aData.N13
