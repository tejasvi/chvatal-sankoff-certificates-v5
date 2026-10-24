import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 582 = cert_data/n13/h13c.vec.part0582, entries 56144953344 .. 56241422335, chunks 13386 .. 13408
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v582 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0582" 385875968 16777216

end CS31aData.N13
