import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 522 = cert_data/n13/h13c.vec.part0522, entries 50356813824 .. 50453282815, chunks 12006 .. 12028
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v522 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0522" 385875968 16777216

end CS31aData.N13
