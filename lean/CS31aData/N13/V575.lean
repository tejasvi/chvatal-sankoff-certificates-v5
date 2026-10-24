import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 575 = cert_data/n13/h13c.vec.part0575, entries 55469670400 .. 55566139391, chunks 13225 .. 13247
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v575 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0575" 385875968 16777216

end CS31aData.N13
