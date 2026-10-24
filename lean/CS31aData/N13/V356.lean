import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 356 = cert_data/n13/h13c.vec.part0356, entries 34342961152 .. 34439430143, chunks 8188 .. 8210
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v356 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0356" 385875968 16777216

end CS31aData.N13
