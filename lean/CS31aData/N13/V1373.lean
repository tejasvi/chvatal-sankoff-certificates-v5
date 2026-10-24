import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1373 = cert_data/n13/h13c.vec.part1373, entries 132451926016 .. 132548395007, chunks 31579 .. 31601
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1373 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1373" 385875968 16777216

end CS31aData.N13
