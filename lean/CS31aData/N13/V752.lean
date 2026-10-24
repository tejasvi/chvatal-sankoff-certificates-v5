import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 752 = cert_data/n13/h13c.vec.part0752, entries 72544681984 .. 72641150975, chunks 17296 .. 17318
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v752 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0752" 385875968 16777216

end CS31aData.N13
