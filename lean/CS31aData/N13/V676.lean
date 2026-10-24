import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 676 = cert_data/n13/h13c.vec.part0676, entries 65213038592 .. 65309507583, chunks 15548 .. 15570
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v676 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0676" 385875968 16777216

end CS31aData.N13
