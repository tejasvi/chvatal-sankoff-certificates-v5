import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 233 = cert_data/n13/h13c.vec.part0233, entries 22477275136 .. 22573744127, chunks 5359 .. 5381
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v233 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0233" 385875968 16777216

end CS31aData.N13
