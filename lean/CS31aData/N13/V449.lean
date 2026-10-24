import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 449 = cert_data/n13/h13c.vec.part0449, entries 43314577408 .. 43411046399, chunks 10327 .. 10349
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v449 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0449" 385875968 16777216

end CS31aData.N13
