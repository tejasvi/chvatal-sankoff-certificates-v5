import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 985 = cert_data/n13/h13c.vec.part0985, entries 95021957120 .. 95118426111, chunks 22655 .. 22677
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v985 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0985" 385875968 16777216

end CS31aData.N13
