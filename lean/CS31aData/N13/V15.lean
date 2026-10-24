import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 15 = cert_data/n13/h13c.vec.part0015, entries 1447034880 .. 1543503871, chunks 345 .. 367
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v15 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0015" 385875968 16777216

end CS31aData.N13
