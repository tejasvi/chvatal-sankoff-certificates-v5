import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 400 = cert_data/n13/h13c.vec.part0400, entries 38587596800 .. 38684065791, chunks 9200 .. 9222
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v400 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0400" 385875968 16777216

end CS31aData.N13
