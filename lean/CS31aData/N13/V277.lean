import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 277 = cert_data/n13/h13c.vec.part0277, entries 26721910784 .. 26818379775, chunks 6371 .. 6393
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v277 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0277" 385875968 16777216

end CS31aData.N13
