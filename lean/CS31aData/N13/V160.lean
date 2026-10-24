import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 160 = cert_data/n13/h13c.vec.part0160, entries 15435038720 .. 15531507711, chunks 3680 .. 3702
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v160 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0160" 385875968 16777216

end CS31aData.N13
