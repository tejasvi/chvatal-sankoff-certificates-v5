import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 659 = cert_data/n13/h13c.vec.part0659, entries 63573065728 .. 63669534719, chunks 15157 .. 15179
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v659 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0659" 385875968 16777216

end CS31aData.N13
