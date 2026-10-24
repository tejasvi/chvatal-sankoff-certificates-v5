import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 934 = cert_data/n13/h13c.vec.part0934, entries 90102038528 .. 90198507519, chunks 21482 .. 21504
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v934 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0934" 385875968 16777216

end CS31aData.N13
