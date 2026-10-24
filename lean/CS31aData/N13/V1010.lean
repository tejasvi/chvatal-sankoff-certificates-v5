import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1010 = cert_data/n13/h13c.vec.part1010, entries 97433681920 .. 97530150911, chunks 23230 .. 23252
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1010 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1010" 385875968 16777216

end CS31aData.N13
