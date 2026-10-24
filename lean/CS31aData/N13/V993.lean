import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 993 = cert_data/n13/h13c.vec.part0993, entries 95793709056 .. 95890178047, chunks 22839 .. 22861
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v993 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0993" 385875968 16777216

end CS31aData.N13
