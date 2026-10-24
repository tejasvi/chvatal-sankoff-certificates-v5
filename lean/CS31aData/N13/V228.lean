import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 228 = cert_data/n13/h13c.vec.part0228, entries 21994930176 .. 22091399167, chunks 5244 .. 5266
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v228 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0228" 385875968 16777216

end CS31aData.N13
