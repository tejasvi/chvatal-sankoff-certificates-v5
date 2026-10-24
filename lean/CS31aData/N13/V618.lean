import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 618 = cert_data/n13/h13c.vec.part0618, entries 59617837056 .. 59714306047, chunks 14214 .. 14236
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v618 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0618" 385875968 16777216

end CS31aData.N13
