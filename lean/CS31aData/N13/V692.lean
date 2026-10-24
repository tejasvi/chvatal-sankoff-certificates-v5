import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 692 = cert_data/n13/h13c.vec.part0692, entries 66756542464 .. 66853011455, chunks 15916 .. 15938
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v692 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0692" 385875968 16777216

end CS31aData.N13
