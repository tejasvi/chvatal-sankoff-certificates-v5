import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 722 = cert_data/n13/h13c.vec.part0722, entries 69650612224 .. 69747081215, chunks 16606 .. 16628
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v722 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0722" 385875968 16777216

end CS31aData.N13
