import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 65 = cert_data/n13/h13c.vec.part0065, entries 6270484480 .. 6366953471, chunks 1495 .. 1517
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v65 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0065" 385875968 16777216

end CS31aData.N13
