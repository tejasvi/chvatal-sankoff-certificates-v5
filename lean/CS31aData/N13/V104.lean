import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 104 = cert_data/n13/h13c.vec.part0104, entries 10032775168 .. 10129244159, chunks 2392 .. 2414
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v104 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0104" 385875968 16777216

end CS31aData.N13
