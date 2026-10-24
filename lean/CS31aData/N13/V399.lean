import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 399 = cert_data/n13/h13c.vec.part0399, entries 38491127808 .. 38587596799, chunks 9177 .. 9199
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v399 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0399" 385875968 16777216

end CS31aData.N13
