import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 361 = cert_data/n13/h13c.vec.part0361, entries 34825306112 .. 34921775103, chunks 8303 .. 8325
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v361 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0361" 385875968 16777216

end CS31aData.N13
