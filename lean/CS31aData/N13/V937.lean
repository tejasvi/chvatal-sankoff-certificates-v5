import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 937 = cert_data/n13/h13c.vec.part0937, entries 90391445504 .. 90487914495, chunks 21551 .. 21573
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v937 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0937" 385875968 16777216

end CS31aData.N13
