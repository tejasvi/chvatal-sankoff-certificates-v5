import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 466 = cert_data/n13/h13c.vec.part0466, entries 44954550272 .. 45051019263, chunks 10718 .. 10740
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v466 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0466" 385875968 16777216

end CS31aData.N13
