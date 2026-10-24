import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 961 = cert_data/n13/h13c.vec.part0961, entries 92706701312 .. 92803170303, chunks 22103 .. 22125
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v961 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0961" 385875968 16777216

end CS31aData.N13
