import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1245 = cert_data/n13/h13c.vec.part1245, entries 120103895040 .. 120200364031, chunks 28635 .. 28657
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1245 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1245" 385875968 16777216

end CS31aData.N13
