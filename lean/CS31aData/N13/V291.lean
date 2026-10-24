import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 291 = cert_data/n13/h13c.vec.part0291, entries 28072476672 .. 28168945663, chunks 6693 .. 6715
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v291 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0291" 385875968 16777216

end CS31aData.N13
