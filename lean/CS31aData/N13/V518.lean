import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 518 = cert_data/n13/h13c.vec.part0518, entries 49970937856 .. 50067406847, chunks 11914 .. 11936
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v518 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0518" 385875968 16777216

end CS31aData.N13
