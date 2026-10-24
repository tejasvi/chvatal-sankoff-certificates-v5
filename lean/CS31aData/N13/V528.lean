import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 528 = cert_data/n13/h13c.vec.part0528, entries 50935627776 .. 51032096767, chunks 12144 .. 12166
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v528 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0528" 385875968 16777216

end CS31aData.N13
