import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1430 = cert_data/n13/h13c.vec.part1430, entries 137950658560 .. 138047127551, chunks 32890 .. 32912
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1430 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1430" 385875968 16777216

end CS31aData.N13
