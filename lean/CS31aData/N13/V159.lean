import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 159 = cert_data/n13/h13c.vec.part0159, entries 15338569728 .. 15435038719, chunks 3657 .. 3679
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v159 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0159" 385875968 16777216

end CS31aData.N13
