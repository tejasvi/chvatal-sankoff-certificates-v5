import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 943 = cert_data/n13/h13c.vec.part0943, entries 90970259456 .. 91066728447, chunks 21689 .. 21711
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v943 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0943" 385875968 16777216

end CS31aData.N13
