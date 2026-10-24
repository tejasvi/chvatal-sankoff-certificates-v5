import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 274 = cert_data/n13/h13c.vec.part0274, entries 26432503808 .. 26528972799, chunks 6302 .. 6324
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v274 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0274" 385875968 16777216

end CS31aData.N13
