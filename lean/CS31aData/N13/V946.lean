import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 946 = cert_data/n13/h13c.vec.part0946, entries 91259666432 .. 91356135423, chunks 21758 .. 21780
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v946 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0946" 385875968 16777216

end CS31aData.N13
