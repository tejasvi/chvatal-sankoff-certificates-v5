import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 892 = cert_data/n13/h13c.vec.part0892, entries 86050340864 .. 86146809855, chunks 20516 .. 20538
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v892 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0892" 385875968 16777216

end CS31aData.N13
