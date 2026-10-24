import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 967 = cert_data/n13/h13c.vec.part0967, entries 93285515264 .. 93381984255, chunks 22241 .. 22263
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v967 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0967" 385875968 16777216

end CS31aData.N13
