import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 734 = cert_data/n13/h13c.vec.part0734, entries 70808240128 .. 70904709119, chunks 16882 .. 16904
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v734 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0734" 385875968 16777216

end CS31aData.N13
