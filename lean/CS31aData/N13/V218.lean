import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 218 = cert_data/n13/h13c.vec.part0218, entries 21030240256 .. 21126709247, chunks 5014 .. 5036
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v218 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0218" 385875968 16777216

end CS31aData.N13
