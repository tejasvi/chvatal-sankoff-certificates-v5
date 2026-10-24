import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 713 = cert_data/n13/h13c.vec.part0713, entries 68782391296 .. 68878860287, chunks 16399 .. 16421
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v713 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0713" 385875968 16777216

end CS31aData.N13
