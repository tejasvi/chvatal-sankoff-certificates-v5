import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 631 = cert_data/n13/h13c.vec.part0631, entries 60871933952 .. 60968402943, chunks 14513 .. 14535
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v631 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0631" 385875968 16777216

end CS31aData.N13
