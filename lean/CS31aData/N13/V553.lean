import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 553 = cert_data/n13/h13c.vec.part0553, entries 53347352576 .. 53443821567, chunks 12719 .. 12741
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v553 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0553" 385875968 16777216

end CS31aData.N13
