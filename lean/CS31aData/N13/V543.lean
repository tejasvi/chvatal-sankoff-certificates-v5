import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 543 = cert_data/n13/h13c.vec.part0543, entries 52382662656 .. 52479131647, chunks 12489 .. 12511
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v543 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0543" 385875968 16777216

end CS31aData.N13
