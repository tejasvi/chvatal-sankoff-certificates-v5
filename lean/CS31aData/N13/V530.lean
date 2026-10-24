import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 530 = cert_data/n13/h13c.vec.part0530, entries 51128565760 .. 51225034751, chunks 12190 .. 12212
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v530 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0530" 385875968 16777216

end CS31aData.N13
