import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 438 = cert_data/n13/h13c.vec.part0438, entries 42253418496 .. 42349887487, chunks 10074 .. 10096
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v438 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0438" 385875968 16777216

end CS31aData.N13
