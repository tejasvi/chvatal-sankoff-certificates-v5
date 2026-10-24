import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 549 = cert_data/n13/h13c.vec.part0549, entries 52961476608 .. 53057945599, chunks 12627 .. 12649
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v549 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0549" 385875968 16777216

end CS31aData.N13
