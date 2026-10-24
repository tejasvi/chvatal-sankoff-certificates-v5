import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 966 = cert_data/n13/h13c.vec.part0966, entries 93189046272 .. 93285515263, chunks 22218 .. 22240
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v966 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0966" 385875968 16777216

end CS31aData.N13
