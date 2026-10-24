import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 485 = cert_data/n13/h13c.vec.part0485, entries 46787461120 .. 46883930111, chunks 11155 .. 11177
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v485 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0485" 385875968 16777216

end CS31aData.N13
