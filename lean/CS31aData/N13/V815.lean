import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 815 = cert_data/n13/h13c.vec.part0815, entries 78622228480 .. 78718697471, chunks 18745 .. 18767
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v815 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0815" 385875968 16777216

end CS31aData.N13
