import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 363 = cert_data/n13/h13c.vec.part0363, entries 35018244096 .. 35114713087, chunks 8349 .. 8371
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v363 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0363" 385875968 16777216

end CS31aData.N13
