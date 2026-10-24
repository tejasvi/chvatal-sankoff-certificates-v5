import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1090 = cert_data/n13/h13c.vec.part1090, entries 105151201280 .. 105247670271, chunks 25070 .. 25092
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1090 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1090" 385875968 16777216

end CS31aData.N13
