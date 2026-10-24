import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 987 = cert_data/n13/h13c.vec.part0987, entries 95214895104 .. 95311364095, chunks 22701 .. 22723
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v987 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0987" 385875968 16777216

end CS31aData.N13
