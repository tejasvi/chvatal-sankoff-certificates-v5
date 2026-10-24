import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 956 = cert_data/n13/h13c.vec.part0956, entries 92224356352 .. 92320825343, chunks 21988 .. 22010
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v956 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0956" 385875968 16777216

end CS31aData.N13
