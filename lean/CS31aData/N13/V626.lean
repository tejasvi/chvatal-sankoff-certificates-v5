import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 626 = cert_data/n13/h13c.vec.part0626, entries 60389588992 .. 60486057983, chunks 14398 .. 14420
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v626 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0626" 385875968 16777216

end CS31aData.N13
