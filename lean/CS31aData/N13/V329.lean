import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 329 = cert_data/n13/h13c.vec.part0329, entries 31738298368 .. 31834767359, chunks 7567 .. 7589
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v329 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0329" 385875968 16777216

end CS31aData.N13
