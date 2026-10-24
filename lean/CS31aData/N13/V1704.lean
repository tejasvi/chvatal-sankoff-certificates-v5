import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1704 = cert_data/n13/h13c.vec.part1704, entries 164383162368 .. 164479631359, chunks 39192 .. 39214
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1704 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1704" 385875968 16777216

end CS31aData.N13
