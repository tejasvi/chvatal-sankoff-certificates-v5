import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1251 = cert_data/n13/h13c.vec.part1251, entries 120682708992 .. 120779177983, chunks 28773 .. 28795
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1251 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1251" 385875968 16777216

end CS31aData.N13
