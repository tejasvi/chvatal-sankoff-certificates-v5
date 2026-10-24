import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 979 = cert_data/n13/h13c.vec.part0979, entries 94443143168 .. 94539612159, chunks 22517 .. 22539
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v979 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0979" 385875968 16777216

end CS31aData.N13
