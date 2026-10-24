import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 766 = cert_data/n13/h13c.vec.part0766, entries 73895247872 .. 73991716863, chunks 17618 .. 17640
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v766 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0766" 385875968 16777216

end CS31aData.N13
