import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 540 = cert_data/n13/h13c.vec.part0540, entries 52093255680 .. 52189724671, chunks 12420 .. 12442
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v540 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0540" 385875968 16777216

end CS31aData.N13
