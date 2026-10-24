import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 368 = cert_data/n13/h13c.vec.part0368, entries 35500589056 .. 35597058047, chunks 8464 .. 8486
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v368 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0368" 385875968 16777216

end CS31aData.N13
