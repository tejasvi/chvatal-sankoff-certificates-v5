import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 560 = cert_data/n13/h13c.vec.part0560, entries 54022635520 .. 54119104511, chunks 12880 .. 12902
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v560 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0560" 385875968 16777216

end CS31aData.N13
