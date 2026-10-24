import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 372 = cert_data/n13/h13c.vec.part0372, entries 35886465024 .. 35982934015, chunks 8556 .. 8578
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v372 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0372" 385875968 16777216

end CS31aData.N13
