import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 161 = cert_data/n13/h13c.vec.part0161, entries 15531507712 .. 15627976703, chunks 3703 .. 3725
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v161 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0161" 385875968 16777216

end CS31aData.N13
