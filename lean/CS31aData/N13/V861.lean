import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 861 = cert_data/n13/h13c.vec.part0861, entries 83059802112 .. 83156271103, chunks 19803 .. 19825
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v861 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0861" 385875968 16777216

end CS31aData.N13
