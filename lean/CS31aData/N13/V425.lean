import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 425 = cert_data/n13/h13c.vec.part0425, entries 40999321600 .. 41095790591, chunks 9775 .. 9797
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v425 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0425" 385875968 16777216

end CS31aData.N13
