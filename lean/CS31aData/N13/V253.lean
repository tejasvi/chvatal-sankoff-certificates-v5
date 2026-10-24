import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 253 = cert_data/n13/h13c.vec.part0253, entries 24406654976 .. 24503123967, chunks 5819 .. 5841
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v253 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0253" 385875968 16777216

end CS31aData.N13
