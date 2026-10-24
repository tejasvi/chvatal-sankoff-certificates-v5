import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1512 = cert_data/n13/h13c.vec.part1512, entries 145861115904 .. 145957584895, chunks 34776 .. 34798
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1512 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1512" 385875968 16777216

end CS31aData.N13
