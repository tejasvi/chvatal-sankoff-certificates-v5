import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 195 = cert_data/n13/h13c.vec.part0195, entries 18811453440 .. 18907922431, chunks 4485 .. 4507
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v195 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0195" 385875968 16777216

end CS31aData.N13
