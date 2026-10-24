import CS31aData.N13

/-! N13, machine share 25 of 56: rows [73971080120, 76929923325) in 320 parallel task(s), with the decoding, the table check
and `globalOK`. -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
theorem cert25 : CS31aCert.checkCert13R 13 lowN13 tabN13 vecN13 165695219469 20 3 4294967296 5 22 wtN13
    8116075413730513074 73971080120 76929923325 320 = true := by
  native_decide

end CS31aData.N13
