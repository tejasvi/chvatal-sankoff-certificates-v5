import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 743 = cert_data/n13/h13c.vec.part0743, entries 71676461056 .. 71772930047, chunks 17089 .. 17111
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v743 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0743" 385875968 16777216

end CS31aData.N13
