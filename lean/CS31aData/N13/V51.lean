import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 51 = cert_data/n13/h13c.vec.part0051, entries 4919918592 .. 5016387583, chunks 1173 .. 1195
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v51 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0051" 385875968 16777216

end CS31aData.N13
