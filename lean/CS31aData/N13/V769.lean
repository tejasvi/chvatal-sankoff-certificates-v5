import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 769 = cert_data/n13/h13c.vec.part0769, entries 74184654848 .. 74281123839, chunks 17687 .. 17709
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v769 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0769" 385875968 16777216

end CS31aData.N13
