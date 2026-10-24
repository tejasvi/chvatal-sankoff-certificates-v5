import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1298 = cert_data/n13/h13c.vec.part1298, entries 125216751616 .. 125313220607, chunks 29854 .. 29876
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1298 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1298" 385875968 16777216

end CS31aData.N13
