import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 971 = cert_data/n13/h13c.vec.part0971, entries 93671391232 .. 93767860223, chunks 22333 .. 22355
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v971 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0971" 385875968 16777216

end CS31aData.N13
