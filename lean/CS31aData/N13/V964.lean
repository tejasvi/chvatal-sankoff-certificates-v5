import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 964 = cert_data/n13/h13c.vec.part0964, entries 92996108288 .. 93092577279, chunks 22172 .. 22194
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v964 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0964" 385875968 16777216

end CS31aData.N13
