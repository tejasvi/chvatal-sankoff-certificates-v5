import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 271 = cert_data/n13/h13c.vec.part0271, entries 26143096832 .. 26239565823, chunks 6233 .. 6255
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v271 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0271" 385875968 16777216

end CS31aData.N13
