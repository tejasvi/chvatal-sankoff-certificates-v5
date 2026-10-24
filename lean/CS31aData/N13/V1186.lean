import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1186 = cert_data/n13/h13c.vec.part1186, entries 114412224512 .. 114508693503, chunks 27278 .. 27300
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1186 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1186" 385875968 16777216

end CS31aData.N13
