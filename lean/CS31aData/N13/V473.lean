import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 473 = cert_data/n13/h13c.vec.part0473, entries 45629833216 .. 45726302207, chunks 10879 .. 10901
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v473 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0473" 385875968 16777216

end CS31aData.N13
