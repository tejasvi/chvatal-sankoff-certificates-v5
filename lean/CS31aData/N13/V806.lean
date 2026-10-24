import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 806 = cert_data/n13/h13c.vec.part0806, entries 77754007552 .. 77850476543, chunks 18538 .. 18560
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v806 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0806" 385875968 16777216

end CS31aData.N13
