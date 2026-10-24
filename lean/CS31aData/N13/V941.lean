import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 941 = cert_data/n13/h13c.vec.part0941, entries 90777321472 .. 90873790463, chunks 21643 .. 21665
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v941 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0941" 385875968 16777216

end CS31aData.N13
