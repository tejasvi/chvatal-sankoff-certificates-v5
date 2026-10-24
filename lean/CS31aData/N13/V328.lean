import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 328 = cert_data/n13/h13c.vec.part0328, entries 31641829376 .. 31738298367, chunks 7544 .. 7566
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v328 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0328" 385875968 16777216

end CS31aData.N13
