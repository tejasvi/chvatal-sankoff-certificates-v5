import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 52 = cert_data/n13/h13c.vec.part0052, entries 5016387584 .. 5112856575, chunks 1196 .. 1218
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v52 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0052" 385875968 16777216

end CS31aData.N13
