import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 319 = cert_data/n13/h13c.vec.part0319, entries 30773608448 .. 30870077439, chunks 7337 .. 7359
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v319 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0319" 385875968 16777216

end CS31aData.N13
