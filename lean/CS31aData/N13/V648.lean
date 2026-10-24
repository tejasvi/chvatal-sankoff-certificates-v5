import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 648 = cert_data/n13/h13c.vec.part0648, entries 62511906816 .. 62608375807, chunks 14904 .. 14926
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v648 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0648" 385875968 16777216

end CS31aData.N13
