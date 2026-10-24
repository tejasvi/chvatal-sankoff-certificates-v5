import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 127 = cert_data/n13/h13c.vec.part0127, entries 12251561984 .. 12348030975, chunks 2921 .. 2943
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v127 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0127" 385875968 16777216

end CS31aData.N13
