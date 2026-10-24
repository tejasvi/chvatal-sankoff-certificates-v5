import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 269 = cert_data/n13/h13c.vec.part0269, entries 25950158848 .. 26046627839, chunks 6187 .. 6209
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v269 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0269" 385875968 16777216

end CS31aData.N13
