import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 773 = cert_data/n13/h13c.vec.part0773, entries 74570530816 .. 74666999807, chunks 17779 .. 17801
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v773 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0773" 385875968 16777216

end CS31aData.N13
