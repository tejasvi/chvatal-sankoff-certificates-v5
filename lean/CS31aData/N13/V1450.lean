import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1450 = cert_data/n13/h13c.vec.part1450, entries 139880038400 .. 139976507391, chunks 33350 .. 33372
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1450 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1450" 385875968 16777216

end CS31aData.N13
