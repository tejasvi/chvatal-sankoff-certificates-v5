import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 991 = cert_data/n13/h13c.vec.part0991, entries 95600771072 .. 95697240063, chunks 22793 .. 22815
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v991 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0991" 385875968 16777216

end CS31aData.N13
