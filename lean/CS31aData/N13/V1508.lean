import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1508 = cert_data/n13/h13c.vec.part1508, entries 145475239936 .. 145571708927, chunks 34684 .. 34706
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1508 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1508" 385875968 16777216

end CS31aData.N13
