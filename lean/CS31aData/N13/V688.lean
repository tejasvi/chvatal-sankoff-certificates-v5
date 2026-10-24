import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 688 = cert_data/n13/h13c.vec.part0688, entries 66370666496 .. 66467135487, chunks 15824 .. 15846
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v688 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0688" 385875968 16777216

end CS31aData.N13
