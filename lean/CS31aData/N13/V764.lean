import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 764 = cert_data/n13/h13c.vec.part0764, entries 73702309888 .. 73798778879, chunks 17572 .. 17594
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v764 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0764" 385875968 16777216

end CS31aData.N13
