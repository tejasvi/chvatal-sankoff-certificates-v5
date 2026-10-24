import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 765 = cert_data/n13/h13c.vec.part0765, entries 73798778880 .. 73895247871, chunks 17595 .. 17617
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v765 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0765" 385875968 16777216

end CS31aData.N13
