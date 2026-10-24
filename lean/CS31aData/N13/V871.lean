import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 871 = cert_data/n13/h13c.vec.part0871, entries 84024492032 .. 84120961023, chunks 20033 .. 20055
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v871 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0871" 385875968 16777216

end CS31aData.N13
