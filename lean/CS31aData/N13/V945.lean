import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 945 = cert_data/n13/h13c.vec.part0945, entries 91163197440 .. 91259666431, chunks 21735 .. 21757
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v945 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0945" 385875968 16777216

end CS31aData.N13
