import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 995 = cert_data/n13/h13c.vec.part0995, entries 95986647040 .. 96083116031, chunks 22885 .. 22907
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v995 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0995" 385875968 16777216

end CS31aData.N13
