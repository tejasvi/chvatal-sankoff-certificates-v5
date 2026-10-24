import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 114 = cert_data/n13/h13c.vec.part0114, entries 10997465088 .. 11093934079, chunks 2622 .. 2644
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v114 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0114" 385875968 16777216

end CS31aData.N13
