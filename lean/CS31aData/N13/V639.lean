import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 639 = cert_data/n13/h13c.vec.part0639, entries 61643685888 .. 61740154879, chunks 14697 .. 14719
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v639 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0639" 385875968 16777216

end CS31aData.N13
