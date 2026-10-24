import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 649 = cert_data/n13/h13c.vec.part0649, entries 62608375808 .. 62704844799, chunks 14927 .. 14949
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v649 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0649" 385875968 16777216

end CS31aData.N13
