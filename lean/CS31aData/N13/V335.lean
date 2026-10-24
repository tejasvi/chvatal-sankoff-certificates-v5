import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 335 = cert_data/n13/h13c.vec.part0335, entries 32317112320 .. 32413581311, chunks 7705 .. 7727
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v335 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0335" 385875968 16777216

end CS31aData.N13
