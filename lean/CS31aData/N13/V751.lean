import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 751 = cert_data/n13/h13c.vec.part0751, entries 72448212992 .. 72544681983, chunks 17273 .. 17295
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v751 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0751" 385875968 16777216

end CS31aData.N13
