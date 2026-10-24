import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 940 = cert_data/n13/h13c.vec.part0940, entries 90680852480 .. 90777321471, chunks 21620 .. 21642
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v940 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0940" 385875968 16777216

end CS31aData.N13
