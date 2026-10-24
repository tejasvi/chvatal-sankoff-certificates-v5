import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 304 = cert_data/n13/h13c.vec.part0304, entries 29326573568 .. 29423042559, chunks 6992 .. 7014
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v304 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0304" 385875968 16777216

end CS31aData.N13
