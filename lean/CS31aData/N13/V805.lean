import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 805 = cert_data/n13/h13c.vec.part0805, entries 77657538560 .. 77754007551, chunks 18515 .. 18537
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v805 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0805" 385875968 16777216

end CS31aData.N13
