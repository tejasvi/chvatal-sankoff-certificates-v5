import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 442 = cert_data/n13/h13c.vec.part0442, entries 42639294464 .. 42735763455, chunks 10166 .. 10188
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v442 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0442" 385875968 16777216

end CS31aData.N13
