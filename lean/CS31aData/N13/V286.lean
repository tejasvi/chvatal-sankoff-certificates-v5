import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 286 = cert_data/n13/h13c.vec.part0286, entries 27590131712 .. 27686600703, chunks 6578 .. 6600
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v286 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0286" 385875968 16777216

end CS31aData.N13
