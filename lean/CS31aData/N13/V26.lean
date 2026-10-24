import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 26 = cert_data/n13/h13c.vec.part0026, entries 2508193792 .. 2604662783, chunks 598 .. 620
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v26 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0026" 385875968 16777216

end CS31aData.N13
