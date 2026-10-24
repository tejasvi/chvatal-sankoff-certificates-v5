import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 40 = cert_data/n13/h13c.vec.part0040, entries 3858759680 .. 3955228671, chunks 920 .. 942
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v40 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0040" 385875968 16777216

end CS31aData.N13
