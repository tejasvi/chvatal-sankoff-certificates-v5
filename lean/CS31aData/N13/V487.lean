import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 487 = cert_data/n13/h13c.vec.part0487, entries 46980399104 .. 47076868095, chunks 11201 .. 11223
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v487 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0487" 385875968 16777216

end CS31aData.N13
