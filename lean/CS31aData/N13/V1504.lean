import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1504 = cert_data/n13/h13c.vec.part1504, entries 145089363968 .. 145185832959, chunks 34592 .. 34614
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1504 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1504" 385875968 16777216

end CS31aData.N13
