---
title: "RSTMGR DV document"
---

<!-- Copy this file to hw/ip/rstmgr/doc/dv/index.md and make changes as needed.
For convenience 'rstmgr' in the document can be searched and replaced easily with the
desired IP (with case sensitivity!). Also, use the testbench block diagram
located at OpenTitan team drive / 'design verification'
as a starting point and modify it to reflect your rstmgr testbench and save it
to hw/ip/rstmgr/doc/dv/tb.svg. It should get linked and rendered under the block
diagram section below. Please update / modify / remove sections below as
applicable. Once done, remove this comment before making a PR. -->

## Goals
* **DV**
  * Verify all RSTMGR IP features by running dynamic simulations with a SV/UVM based testbench
  * Develop and run all tests based on the [DV plan](#dv-plan) below towards closing code and functional coverage on the IP and all of its sub-modules
* **FPV**
  * Verify TileLink device protocol compliance with an SVA based testbench

## Current status
* [Design & verification stage]({{< relref "hw" >}})
  * [HW development stages]({{< relref "doc/project/development_stages" >}})
* [Simulation results](https://reports.opentitan.org/hw/ip/rstmgr/dv/latest/results.html)

## Design features
For detailed information on RSTMGR design features, please see the [RSTMGR HWIP technical specification]({{< relref "hw/ip/rstmgr/doc" >}}).

## Testbench architecture
RSTMGR testbench has been constructed based on the [CIP testbench architecture]({{< relref "hw/dv/sv/cip_lib/doc" >}}).

### Block diagram
![Block diagram](tb.svg)

### Top level testbench
The top level testbench is located at `hw/ip/rstmgr/dv/tb.sv`.
It instantiates the RSTMGR DUT module `hw/top_earlgrey/ip/rstmgr/rtl/autogen/rstmgr.sv`.
In addition, it instantiates the following interfaces, connects them to the DUT and sets their handle into `uvm_config_db`:
* [Clock and reset interface]({{< relref "hw/dv/sv/common_ifs" >}})
* [TileLink host interface]({{< relref "hw/dv/sv/tl_agent/README.md" >}})
* RSTMGR interface `hw/ip/rstmgr/dv/env/rstmgr_if.sv`
* Alerts ([`alert_esc_if`]({{< relref "hw/dv/sv/alert_esc_agent/README.md" >}}))
* Devmode ([`pins_if`]({{< relref "hw/dv/sv/common_ifs" >}}))

### Common DV utility components
The following utilities provide generic helper tasks and functions to perform activities that are common across the project:
* [dv_utils_pkg]({{< relref "hw/dv/sv/dv_utils/README.md" >}})
* [csr_utils_pkg]({{< relref "hw/dv/sv/csr_utils/README.md" >}})

### Compile-time configurations
[list compile time configurations, if any and what are they used for]

### Global types & methods
All common types and methods defined at the package level can be found in
`rstmgr_env_pkg`. Some of them in use are:
```systemverilog
[list a few parameters, types & methods; no need to mention all]
```
### TL_agent
The RSTMGR testbench instantiates (already handled in CIP base env) [tl_agent]({{< relref "hw/dv/sv/tl_agent/README.md" >}}).
This provides the ability to drive and independently monitor random traffic via the TL host interface into the RSTMGR device.

### Alert_agents
RSTMGR testbench instantiates (already handled in CIP base env) [alert_agents]({{< relref "hw/dv/sv/alert_esc_agent/README.md" >}}):
[list alert names].
The alert_agents provide the ability to drive and independently monitor alert handshakes via alert interfaces in RSTMGR device.

### UVC/agent 1
[Describe here or add link to its README]

### UVC/agent 2
[Describe here or add link to its README]

### UVM RAL Model
The RSTMGR RAL model is created with the [`ralgen`]({{< relref "hw/dv/tools/ralgen/README.md" >}}) FuseSoC generator script automatically when the simulation is at the build stage.

It can be created manually by invoking [`regtool`]({{< relref "util/reggen/README.md" >}}):

### Reference models
[Describe reference models in use if applicable, example: SHA256/HMAC]

### Stimulus strategy
The following test sequences and covergroupsare described in more detail in the testplan at `hw/ip/pwrmgr/data/rstmgr_testplan.hjson`, and also included [below](#dv-plan).

#### Test sequences
The test sequences reside in `hw/ip/rstmgr/dv/env/seq_lib`.
All test sequences are extended from `rstmgr_base_vseq`, which is extended from `cip_base_vseq` and serves as a starting point.
It provides commonly used handles, variables, functions and tasks that the test sequences can simple use / call.
Some of the most commonly used tasks / functions are as follows:
* task `wait_for_cpu_out_of_reset`:
  Waits for the `resets_o.rst_sys_n[1]` to go high, indicating the CPU is out of reset and CSRs can be accessed.
* task 2:

The `rstmgr_smoke_vseq` tests the rstmgr through software initiated low power, peripheral reset, ndm reset, and software initiated resets.

#### Functional coverage
To ensure high quality constrained random stimulus, it is necessary to develop a functional coverage model.
The following covergroups have been developed to prove that the test intent has been adequately met:
* cg1:
* cg2:

### Self-checking strategy
#### Scoreboard
The `rstmgr_scoreboard` is primarily used for end to end checking.
It creates the following analysis ports to retrieve the data monitored by corresponding interface agents:
* analysis port1:
* analysis port2:
<!-- explain inputs monitored, flow of data and outputs checked -->

#### Assertions
* TLUL assertions: The `tb/rstmgr_bind.sv` file binds the `tlul_assert` [assertions]({{< relref "hw/ip/tlul/doc/TlulProtocolChecker.md" >}}) to the IP to ensure TileLink interface protocol compliance.
* Unknown checks on DUT outputs: The RTL has assertions to ensure all outputs are initialized to known values after coming out of reset.
* assert prop 1:
* assert prop 2:

## Building and running tests
We are using our in-house developed [regression tool]({{< relref "hw/dv/tools/README.md" >}}) for building and running our tests and regressions.
Please take a look at the link for detailed information on the usage, capabilities, features and known issues.
Here's how to run a smoke test:
```console
$ $REPO_TOP/util/dvsim/dvsim.py $REPO_TOP/hw/ip/rstmgr/dv/rstmgr_sim_cfg.hjson -i rstmgr_smoke
```

## DV plan
<!-- TODO: uncomment the line below after adding the testplan.
Please make sure the testplan is added to `/util/build_docs.py`. -->
{{</* incGenFromIpDesc "hw/ip/rstmgr/data/rstmgr_testplan.hjson" "testplan" */>}}
