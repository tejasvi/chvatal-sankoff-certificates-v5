import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1363 = cert_data/n13/h13c.vec.part1363, entries 131487236096 .. 131583705087, chunks 31349 .. 31371
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1363 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1363" 385875968 16777216

end CS31aData.N13
