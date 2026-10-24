import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 131 = cert_data/n13/h13c.vec.part0131, entries 12637437952 .. 12733906943, chunks 3013 .. 3035
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v131 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0131" 385875968 16777216

end CS31aData.N13
