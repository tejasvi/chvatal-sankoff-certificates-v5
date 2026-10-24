import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 87 = cert_data/n13/h13c.vec.part0087, entries 8392802304 .. 8489271295, chunks 2001 .. 2023
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v87 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0087" 385875968 16777216

end CS31aData.N13
