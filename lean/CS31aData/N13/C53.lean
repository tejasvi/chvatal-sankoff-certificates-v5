import CS31aData.N13

/-! N13, machine share 53 of 56: rows [156818689855, 159777533059) in 320 parallel task(s), with the decoding, the table check
and `globalOK`. -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
theorem cert53 : CS31aCert.checkCert13R 13 lowN13 tabN13 vecN13 165695219469 20 3 4294967296 5 22 wtN13
    8116075413730513074 156818689855 159777533059 320 = true := by
  native_decide

end CS31aData.N13
