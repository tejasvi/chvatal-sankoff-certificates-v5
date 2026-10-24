import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 226 = cert_data/n13/h13c.vec.part0226, entries 21801992192 .. 21898461183, chunks 5198 .. 5220
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v226 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0226" 385875968 16777216

end CS31aData.N13
