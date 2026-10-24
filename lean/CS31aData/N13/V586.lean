import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 586 = cert_data/n13/h13c.vec.part0586, entries 56530829312 .. 56627298303, chunks 13478 .. 13500
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v586 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0586" 385875968 16777216

end CS31aData.N13
