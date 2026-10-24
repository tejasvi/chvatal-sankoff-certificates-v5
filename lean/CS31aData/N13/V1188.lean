import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1188 = cert_data/n13/h13c.vec.part1188, entries 114605162496 .. 114701631487, chunks 27324 .. 27346
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1188 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1188" 385875968 16777216

end CS31aData.N13
