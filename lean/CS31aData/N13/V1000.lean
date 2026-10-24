import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1000 = cert_data/n13/h13c.vec.part1000, entries 96468992000 .. 96565460991, chunks 23000 .. 23022
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1000 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1000" 385875968 16777216

end CS31aData.N13
