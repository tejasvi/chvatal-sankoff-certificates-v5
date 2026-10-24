import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 320 = cert_data/n13/h13c.vec.part0320, entries 30870077440 .. 30966546431, chunks 7360 .. 7382
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v320 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0320" 385875968 16777216

end CS31aData.N13
