////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 1.8
//  \   \         Application : Virtex-6 FPGA GTX Transceiver Wizard  
//  /   /         Filename : trg_tx_buf_bypass.v
// /___/   /\     Timestamp : 
// \   \  /  \ 
//  \___\/\___\ 
//
//
// Instantiation Template
// Generated by Xilinx Virtex-6 FPGA GTX Transceiver Wizard
// 
// 
// (c) Copyright 2009-2010 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES. 


// Use the templates in this file to add the components generated by the wizard to your
// design. 

   

    //--------------------------- The GTX Wrapper -----------------------------


    TRG_TX_BUF_BYPASS #
    (
        .WRAPPER_SIM_GTXRESET_SPEEDUP   (0)      // Set this to 1 for simulation
    )
    trg_tx_buf_bypass_i
    (
        //_____________________________________________________________________
        //_____________________________________________________________________
        //GTX0  (X0Y2)

        //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
        .GTX0_RXN_IN                    (),
        .GTX0_RXP_IN                    (),
        //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
        .GTX0_TXCHARISK_IN              (),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .GTX0_TXDATA_IN                 (),
        .GTX0_TXOUTCLK_OUT              (),
        .GTX0_TXUSRCLK_IN               (),
        .GTX0_TXUSRCLK2_IN              (),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .GTX0_TXN_OUT                   (),
        .GTX0_TXP_OUT                   (),
        //------ Transmit Ports - TX Elastic Buffer and Phase Alignment Ports ------
        .GTX0_TXDLYALIGNDISABLE_IN      (),
        .GTX0_TXDLYALIGNMONENB_IN       (),
        .GTX0_TXDLYALIGNMONITOR_OUT     (),
        .GTX0_TXDLYALIGNRESET_IN        (),
        .GTX0_TXENPMAPHASEALIGN_IN      (),
        .GTX0_TXPMASETPHASE_IN          (),
        //--------------------- Transmit Ports - TX PLL Ports ----------------------
        .GTX0_GTXTXRESET_IN             (),
        .GTX0_MGTREFCLKTX_IN            (),
        .GTX0_PLLTXRESET_IN             (),
        .GTX0_TXPLLLKDET_OUT            (),
        .GTX0_TXRESETDONE_OUT           ()


    );
    



    //---------------------Dedicated GTX Reference Clock Inputs ---------------
    // Each dedicated refclk you are using in your design will need its own IBUFDS_GTXE1 instance
    
    IBUFDS_GTXE1 q1_clk1_refclk_ibufds_i
    (
        .O                              (),
        .ODIV2                          (),
        .CEB                            (),
        .I                              (),  // Connect to package pin AB6
        .IB                             ()  // Connect to package pin AB5
    );




    //---------------------------- TXSYNC module ------------------------------
    // Since you are bypassing the TX Buffer in your wrapper, you will need to drive
    // the phase alignment ports to align the phase of the TX Datapath. Include
    // this module in your design to have phase alignment performed automatically as
    // it is done in the example design.

        
    TX_SYNC gtx0_txsync_i 
    (
        .TXENPMAPHASEALIGN              ()      
        .TXPMASETPHASE                  ()
        .TXDLYALIGNDISABLE              ()
        .TXDLYALIGNRESET                ()
        .SYNC_DONE                      ()
        .USER_CLK                       ()
        .RESET                          (),
    );
        



