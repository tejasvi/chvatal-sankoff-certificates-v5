import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 759 = cert_data/n13/h13c.vec.part0759, entries 73219964928 .. 73316433919, chunks 17457 .. 17479
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v759 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0759" 385875968 16777216

end CS31aData.N13
