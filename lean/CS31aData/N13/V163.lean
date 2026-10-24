import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 163 = cert_data/n13/h13c.vec.part0163, entries 15724445696 .. 15820914687, chunks 3749 .. 3771
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v163 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0163" 385875968 16777216

end CS31aData.N13
