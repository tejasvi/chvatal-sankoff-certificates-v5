import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 103 = cert_data/n13/h13c.vec.part0103, entries 9936306176 .. 10032775167, chunks 2369 .. 2391
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v103 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0103" 385875968 16777216

end CS31aData.N13
