import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 462 = cert_data/n13/h13c.vec.part0462, entries 44568674304 .. 44665143295, chunks 10626 .. 10648
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v462 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0462" 385875968 16777216

end CS31aData.N13
