import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 904 = cert_data/n13/h13c.vec.part0904, entries 87207968768 .. 87304437759, chunks 20792 .. 20814
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v904 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0904" 385875968 16777216

end CS31aData.N13
