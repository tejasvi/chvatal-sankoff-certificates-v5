import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 456 = cert_data/n13/h13c.vec.part0456, entries 43989860352 .. 44086329343, chunks 10488 .. 10510
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v456 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0456" 385875968 16777216

end CS31aData.N13
