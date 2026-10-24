import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 72 = cert_data/n13/h13c.vec.part0072, entries 6945767424 .. 7042236415, chunks 1656 .. 1678
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v72 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0072" 385875968 16777216

end CS31aData.N13
