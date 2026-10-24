import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 954 = cert_data/n13/h13c.vec.part0954, entries 92031418368 .. 92127887359, chunks 21942 .. 21964
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v954 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0954" 385875968 16777216

end CS31aData.N13
