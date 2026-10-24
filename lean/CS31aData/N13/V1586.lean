import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1586 = cert_data/n13/h13c.vec.part1586, entries 152999821312 .. 153096290303, chunks 36478 .. 36500
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1586 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1586" 385875968 16777216

end CS31aData.N13
