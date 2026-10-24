import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 39 = cert_data/n13/h13c.vec.part0039, entries 3762290688 .. 3858759679, chunks 897 .. 919
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v39 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0039" 385875968 16777216

end CS31aData.N13
