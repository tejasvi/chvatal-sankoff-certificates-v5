import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 842 = cert_data/n13/h13c.vec.part0842, entries 81226891264 .. 81323360255, chunks 19366 .. 19388
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v842 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0842" 385875968 16777216

end CS31aData.N13
