import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 817 = cert_data/n13/h13c.vec.part0817, entries 78815166464 .. 78911635455, chunks 18791 .. 18813
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v817 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0817" 385875968 16777216

end CS31aData.N13
