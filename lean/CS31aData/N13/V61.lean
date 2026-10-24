import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 61 = cert_data/n13/h13c.vec.part0061, entries 5884608512 .. 5981077503, chunks 1403 .. 1425
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v61 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0061" 385875968 16777216

end CS31aData.N13
