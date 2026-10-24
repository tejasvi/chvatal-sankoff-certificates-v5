import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 881 = cert_data/n13/h13c.vec.part0881, entries 84989181952 .. 85085650943, chunks 20263 .. 20285
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v881 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0881" 385875968 16777216

end CS31aData.N13
