import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 507 = cert_data/n13/h13c.vec.part0507, entries 48909778944 .. 49006247935, chunks 11661 .. 11683
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v507 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0507" 385875968 16777216

end CS31aData.N13
