                Core name: Xilinx LogiCORE Virtex-6 GTX Transceiver Wizard
                Version: 1.8
                Release Date: December 14, 2010


================================================================================

This document contains the following sections:

1. Introduction
2. New Features
3. Supported Devices
4. Resolved Issues
5. Known Issues
6. Technical Support
7. Other Information 
8. Core Release History
9. Legal Disclaimer

================================================================================


1. INTRODUCTION

For installation instructions for this release, please go to:

   http://www.xilinx.com/ipcenter/coregen/ip_update_install_instructions.htm

For system requirements:

   http://www.xilinx.com/ipcenter/coregen/ip_update_system_requirements.htm

This file contains release notes for the Xilinx LogiCORE IP Virtex-6 FPGA GTX
Transceiver Wizard v1.8 solution. For the latest core updates, see the product page at:

   http://www.xilinx.com/products/ipcenter/V6_GTX_Wizard.htm


2. NEW FEATURES

- ISE 12.4 software support



3. SUPPORTED DEVICES
 
The following device families are supported by the core for this release.

Virtex-6 XC CXT/LXT/SXT/HXT
Virtex-6 XQ LXT/SXT                                                       
Virtex-6 -1L XC LXT/SXT 


4. RESOLVED ISSUES

- CR 573806 - Double Reset Circuit is moved from example design to GT wrapper
- CR 579220 - Fixed the error in example design when GREFCLK is used
- CR 574899 - Advanced Clocking Mode option in GUI to enable Dynamic Clock Selection
- CR 574682 - Modified Display Port Template to support Dynamic Clock Selection


5. KNOWN ISSUES

The following are known issues for v1.8 of this core at time of release:

- The transceiver attributes are not validated on the latest production silicon

- When the RX Buffer is bypassed, the RX delay aligner logic uses the DRP Port.
  Currently, there is no arbitration logic to enable user accesses to the DRP
  when RX delay aligner is active.
  The RX delay aligner logic is enabled for line rates 2.4GHz and above. This 
  logic works for silicon revision 2.0 and above.

The most recent information, including known issues, workarounds, and
resolutions for this version is provided in the IP Release Notes Guide
located at

   www.xilinx.com/support/documentation/user_guides/xtp025.pdf


6. TECHNICAL SUPPORT

To obtain technical support, create a WebCase at www.xilinx.com/support.
Questions are routed to a team with expertise using this product.

Xilinx provides technical support for use of this product when used
according to the guidelines described in the core documentation, and
cannot guarantee timing, functionality, or support of this product for
designs that do not follow specified guidelines.


7. OTHER INFORMATION 

- Display Port, Fiber Channel 1G, 2G, 4G, OC48, SATA-I and SATA-II protocol files are not tested for compliance
- For Display Port protocol, set TX/RXPLL_DIVSEL_FB=2, TX/RXPLL_DIVSEL_REF=1, TX/RXPLL_DIVSEL_OUT=1
- For SATA-II protocol, set TX/RXPLL_DIVSEL_FB=2, TX/RXPLL_DIVSEL_REF=2, TX/RXPLL_DIVSEL_OUT=1
- The transceiver attributes of v1.8 version of this core support 2.01 silicon
  revision


8. CORE RELEASE HISTORY

Date        By            Version      Description
================================================================================
12/14/2010  Xilinx, Inc.  1.8          ISE 12.4 support
09/21/2010  Xilinx, Inc.  1.7          ISE 12.3 support
07/23/2010  Xilinx, Inc.  1.6          ISE 12.2 support
04/19/2010  Xilinx, Inc.  1.5          ISE 12.1 support
12/02/2009  Xilinx, Inc.  1.4          ISE 11.4 support
09/16/2009  Xilinx, Inc.  1.3          ISE 11.3 support
06/24/2009  Xilinx, Inc.  1.2          ISE 11.2 support
04/24/2009  Xilinx, Inc.  1.1          ISE 11.1 support
================================================================================


9. LEGAL DISCLAIMER

(c) Copyright 2009- 2010 Xilinx, Inc. All rights reserved.

This file contains confidential and proprietary information
of Xilinx, Inc. and is protected under U.S. and
international copyright and other intellectual property
laws.

DISCLAIMER
This disclaimer is not a license and does not grant any
rights to the materials distributed herewith. Except as
otherwise provided in a valid license issued to you by
Xilinx, and to the maximum extent permitted by applicable
law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
(2) Xilinx shall not be liable (whether in contract or tort,
including negligence, or under any other theory of
liability) for any loss or damage of any kind or nature
related to, arising under or in connection with these
materials, including for any direct, or any indirect,
special, incidental, or consequential loss or damage
(including loss of data, profits, goodwill, or any type of
loss or damage suffered as a result of any action brought
by a third party) even if such damage or loss was
reasonably foreseeable or Xilinx had been advised of the
possibility of the same.

CRITICAL APPLICATIONS
Xilinx products are not designed or intended to be fail-
safe, or for use in any application requiring fail-safe
performance, such as life-support or safety devices or
systems, Class III medical devices, nuclear facilities,
applications related to the deployment of airbags, or any
other applications that could lead to death, personal
injury, or severe property or environmental damage
(individually and collectively, "Critical
Applications"). Customer assumes the sole risk and
liability of any use of Xilinx products in Critical
Applications, subject only to applicable laws and
regulations governing limitations on product liability.

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
PART OF THIS FILE AT ALL TIMES.

