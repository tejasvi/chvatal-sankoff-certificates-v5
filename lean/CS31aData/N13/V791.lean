import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 791 = cert_data/n13/h13c.vec.part0791, entries 76306972672 .. 76403441663, chunks 18193 .. 18215
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v791 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0791" 385875968 16777216

end CS31aData.N13
