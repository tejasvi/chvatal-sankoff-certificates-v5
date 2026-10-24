import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 873 = cert_data/n13/h13c.vec.part0873, entries 84217430016 .. 84313899007, chunks 20079 .. 20101
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v873 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0873" 385875968 16777216

end CS31aData.N13
