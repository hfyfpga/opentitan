// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

module rstmgr_bind;

  bind rstmgr tlul_assert #(
    .EndpointType("Device")
  ) tlul_assert_device (.clk_i, .rst_ni, .h2d(tl_i), .d2h(tl_o));

  bind rstmgr rstmgr_csr_assert_fpv rstmgr_csr_assert (.clk_i, .rst_ni, .h2d(tl_i), .d2h(tl_o));

endmodule
