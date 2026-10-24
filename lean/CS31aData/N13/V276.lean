import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 276 = cert_data/n13/h13c.vec.part0276, entries 26625441792 .. 26721910783, chunks 6348 .. 6370
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v276 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0276" 385875968 16777216

end CS31aData.N13
