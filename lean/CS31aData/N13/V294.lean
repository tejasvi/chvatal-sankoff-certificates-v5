import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 294 = cert_data/n13/h13c.vec.part0294, entries 28361883648 .. 28458352639, chunks 6762 .. 6784
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v294 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0294" 385875968 16777216

end CS31aData.N13
