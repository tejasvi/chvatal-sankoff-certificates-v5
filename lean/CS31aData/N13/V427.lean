import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 427 = cert_data/n13/h13c.vec.part0427, entries 41192259584 .. 41288728575, chunks 9821 .. 9843
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v427 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0427" 385875968 16777216

end CS31aData.N13
