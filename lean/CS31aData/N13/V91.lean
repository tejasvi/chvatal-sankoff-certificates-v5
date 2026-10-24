import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 91 = cert_data/n13/h13c.vec.part0091, entries 8778678272 .. 8875147263, chunks 2093 .. 2115
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v91 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0091" 385875968 16777216

end CS31aData.N13
