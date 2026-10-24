import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1161 = cert_data/n13/h13c.vec.part1161, entries 112000499712 .. 112096968703, chunks 26703 .. 26725
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1161 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1161" 385875968 16777216

end CS31aData.N13
