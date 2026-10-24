import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 735 = cert_data/n13/h13c.vec.part0735, entries 70904709120 .. 71001178111, chunks 16905 .. 16927
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v735 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0735" 385875968 16777216

end CS31aData.N13
