import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 731 = cert_data/n13/h13c.vec.part0731, entries 70518833152 .. 70615302143, chunks 16813 .. 16835
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v731 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0731" 385875968 16777216

end CS31aData.N13
