import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 341 = cert_data/n13/h13c.vec.part0341, entries 32895926272 .. 32992395263, chunks 7843 .. 7865
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v341 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0341" 385875968 16777216

end CS31aData.N13
