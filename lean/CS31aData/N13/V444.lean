import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 444 = cert_data/n13/h13c.vec.part0444, entries 42832232448 .. 42928701439, chunks 10212 .. 10234
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v444 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0444" 385875968 16777216

end CS31aData.N13
