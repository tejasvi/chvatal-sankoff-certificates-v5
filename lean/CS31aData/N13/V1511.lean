import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1511 = cert_data/n13/h13c.vec.part1511, entries 145764646912 .. 145861115903, chunks 34753 .. 34775
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1511 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1511" 385875968 16777216

end CS31aData.N13
