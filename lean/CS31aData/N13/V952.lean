import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 952 = cert_data/n13/h13c.vec.part0952, entries 91838480384 .. 91934949375, chunks 21896 .. 21918
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v952 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0952" 385875968 16777216

end CS31aData.N13
