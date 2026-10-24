import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 756 = cert_data/n13/h13c.vec.part0756, entries 72930557952 .. 73027026943, chunks 17388 .. 17410
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v756 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0756" 385875968 16777216

end CS31aData.N13
