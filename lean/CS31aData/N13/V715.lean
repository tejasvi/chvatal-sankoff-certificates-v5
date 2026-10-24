import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 715 = cert_data/n13/h13c.vec.part0715, entries 68975329280 .. 69071798271, chunks 16445 .. 16467
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v715 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0715" 385875968 16777216

end CS31aData.N13
