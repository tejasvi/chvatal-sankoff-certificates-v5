import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 78 = cert_data/n13/h13c.vec.part0078, entries 7524581376 .. 7621050367, chunks 1794 .. 1816
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v78 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0078" 385875968 16777216

end CS31aData.N13
