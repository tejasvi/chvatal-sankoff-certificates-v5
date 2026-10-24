import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 992 = cert_data/n13/h13c.vec.part0992, entries 95697240064 .. 95793709055, chunks 22816 .. 22838
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v992 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0992" 385875968 16777216

end CS31aData.N13
