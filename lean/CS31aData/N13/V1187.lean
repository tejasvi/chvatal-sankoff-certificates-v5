import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1187 = cert_data/n13/h13c.vec.part1187, entries 114508693504 .. 114605162495, chunks 27301 .. 27323
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1187 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1187" 385875968 16777216

end CS31aData.N13
