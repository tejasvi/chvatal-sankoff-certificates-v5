import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 675 = cert_data/n13/h13c.vec.part0675, entries 65116569600 .. 65213038591, chunks 15525 .. 15547
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v675 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0675" 385875968 16777216

end CS31aData.N13
