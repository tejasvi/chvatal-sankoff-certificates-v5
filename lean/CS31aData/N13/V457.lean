import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 457 = cert_data/n13/h13c.vec.part0457, entries 44086329344 .. 44182798335, chunks 10511 .. 10533
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v457 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0457" 385875968 16777216

end CS31aData.N13
