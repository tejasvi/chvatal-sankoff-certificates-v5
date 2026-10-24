import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 877 = cert_data/n13/h13c.vec.part0877, entries 84603305984 .. 84699774975, chunks 20171 .. 20193
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v877 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0877" 385875968 16777216

end CS31aData.N13
