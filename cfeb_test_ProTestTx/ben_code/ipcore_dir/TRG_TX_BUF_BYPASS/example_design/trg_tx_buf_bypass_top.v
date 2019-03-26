////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 1.8
//  \   \         Application : Virtex-6 FPGA GTX Transceiver Wizard 
//  /   /         Filename : trg_tx_buf_bypass_top.v
// /___/   /\     Timestamp : 
// \   \  /  \ 
//  \___\/\___\ 
//
//
// Module TRG_TX_BUF_BYPASS_TOP
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


`timescale 1ns / 1ps
`define DLY #1


//***********************************Entity Declaration************************

module TRG_TX_BUF_BYPASS_TOP #
(
    parameter EXAMPLE_CONFIG_INDEPENDENT_LANES          =   1,   //configuration for frame gen and check
    parameter EXAMPLE_LANE_WITH_START_CHAR              =   0,    // specifies lane with unique start frame char
    parameter EXAMPLE_WORDS_IN_BRAM                     =   512,  // specifies amount of data in BRAM
    parameter EXAMPLE_SIM_GTXRESET_SPEEDUP              =   0,    // simulation setting for GTX SecureIP model
    parameter EXAMPLE_USE_CHIPSCOPE                     =   1,    // Set to 1 to use Chipscope to drive resets
    parameter ALIGNER_WAIT                              =   8'd32 // To set the wait cycles in aligner
)
(
    input wire  Q1_CLK1_MGTREFCLK_PAD_N_IN,
    input wire  Q1_CLK1_MGTREFCLK_PAD_P_IN,
    input wire  GTXTXRESET_IN,
    input wire  GTXRXRESET_IN,
    input  wire         RXN_IN,
    input  wire         RXP_IN,
    output wire         TXN_OUT,
    output wire         TXP_OUT
);


//************************** Register Declarations ****************************

    reg     [84:0]  ila_in_r;

    reg             gtx0_txresetdone_r;
    reg             gtx0_txresetdone_r2;
    //------------------------ MGT Wrapper Wires ------------------------------
    //________________________________________________________________________
    //________________________________________________________________________
    //GTX0   (X0Y2)

    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    wire    [3:0]   gtx0_txcharisk_i;
    //---------------- Transmit Ports - TX Data Path interface -----------------
    wire    [31:0]  gtx0_txdata_i;
    wire            gtx0_txoutclk_i;
    //------ Transmit Ports - TX Elastic Buffer and Phase Alignment Ports ------
    wire            gtx0_txdlyaligndisable_i;
    wire            gtx0_txdlyalignmonenb_i;
    wire    [7:0]   gtx0_txdlyalignmonitor_i;
    wire            gtx0_txdlyalignreset_i;
    wire            gtx0_txenpmaphasealign_i;
    wire            gtx0_txpmasetphase_i;
    //--------------------- Transmit Ports - TX PLL Ports ----------------------
    wire            gtx0_gtxtxreset_i;
    wire            gtx0_plltxreset_i;
    wire            gtx0_txplllkdet_i;
    wire            gtx0_txresetdone_i;




    //----------------------------- Global Signals -----------------------------
    wire            gtx0_tx_system_reset_c;
    wire            gtx0_rx_system_reset_c;
    wire            tied_to_ground_i;
    wire    [63:0]  tied_to_ground_vec_i;
    wire            tied_to_vcc_i;
    wire    [7:0]   tied_to_vcc_vec_i;
    wire            drp_clk_in_i;

    //--------------------------- User Clocks ---------------------------------
    wire            gtx0_txusrclk_i;
    wire            gtx0_txusrclk2_i;
    wire            txoutclk_mmcm0_locked_i;
    wire            txoutclk_mmcm0_reset_i;
    wire            gtx0_txoutclk_to_mmcm_i;


    //--------------------------- Reference Clocks ----------------------------
    
    wire            q1_clk1_refclk_i;
    wire            q1_clk1_refclk_i_bufg;
    //--------------------- Frame check/gen Module Signals --------------------
    wire            gtx0_matchn_i;
    
    wire    [7:0]   gtx0_txdata_float_i;
    
    
    wire            gtx0_block_sync_i;
    wire            gtx0_track_data_i;
    wire    [7:0]   gtx0_error_count_i;
    wire            gtx0_frame_check_reset_i;
    wire            gtx0_inc_in_i;
    wire            gtx0_inc_out_i;
    wire    [15:0]  gtx0_unscrambled_data_i;

    wire            reset_on_data_error_i;
    wire            track_data_out_i;

    //----------------------- Sync Module Signals -----------------------------


    wire            gtx0_tx_sync_done_i;
    wire            gtx0_reset_txsync_c;

    //--------------------- Chipscope Signals ---------------------------------

    wire    [35:0]  tx_data_vio_control_i;
    wire    [35:0]  rx_data_vio_control_i;
    wire    [35:0]  shared_vio_control_i;
    wire    [35:0]  ila_control_i;
    wire    [31:0]  tx_data_vio_async_in_i;
    wire    [31:0]  tx_data_vio_sync_in_i;
    wire    [31:0]  tx_data_vio_async_out_i;
    wire    [31:0]  tx_data_vio_sync_out_i;
    wire    [31:0]  rx_data_vio_async_in_i;
    wire    [31:0]  rx_data_vio_sync_in_i;
    wire    [31:0]  rx_data_vio_async_out_i;
    wire    [31:0]  rx_data_vio_sync_out_i;
    wire    [31:0]  shared_vio_in_i;
    wire    [31:0]  shared_vio_out_i;
    wire    [84:0]  ila_in_i;

    wire    [31:0]  gtx0_tx_data_vio_async_in_i;
    wire    [31:0]  gtx0_tx_data_vio_sync_in_i;
    wire    [31:0]  gtx0_tx_data_vio_async_out_i;
    wire    [31:0]  gtx0_tx_data_vio_sync_out_i;
    wire    [31:0]  gtx0_rx_data_vio_async_in_i;
    wire    [31:0]  gtx0_rx_data_vio_sync_in_i;
    wire    [31:0]  gtx0_rx_data_vio_async_out_i;
    wire    [31:0]  gtx0_rx_data_vio_sync_out_i;
    wire    [84:0]  gtx0_ila_in_i;


    wire            gtxtxreset_i;
    wire            gtxrxreset_i;

    wire            user_tx_reset_i;
    wire            user_rx_reset_i;
    wire            tx_vio_clk_i;
    wire            tx_vio_clk_mux_out_i;    
    wire            rx_vio_ila_clk_i;
    wire            rx_vio_ila_clk_mux_out_i;

//**************************** Main Body of Code *******************************

    //  Static signal Assigments    
    assign tied_to_ground_i             = 1'b0;
    assign tied_to_ground_vec_i         = 64'h0000000000000000;
    assign tied_to_vcc_i                = 1'b1;
    assign tied_to_vcc_vec_i            = 8'hff;



    //---------------------Dedicated GTX Reference Clock Inputs ---------------
    // The dedicated reference clock inputs you selected in the GUI are implemented using
    // IBUFDS_GTXE1 instances.
    //
    // In the UCF file for this example design, you will see that each of
    // these IBUFDS_GTXE1 instances has been LOCed to a particular set of pins. By LOCing to these
    // locations, we tell the tools to use the dedicated input buffers to the GTX reference
    // clock network, rather than general purpose IOs. To select other pins, consult the 
    // Implementation chapter of UG___, or rerun the wizard.
    //
    // This network is the highest performace (lowest jitter) option for providing clocks
    // to the GTX transceivers.
    
    IBUFDS_GTXE1 q1_clk1_refclk_ibufds_i
    (
        .O                              (q1_clk1_refclk_i),
        .ODIV2                          (),
        .CEB                            (tied_to_ground_i),
        .I                              (Q1_CLK1_MGTREFCLK_PAD_P_IN),
        .IB                             (Q1_CLK1_MGTREFCLK_PAD_N_IN)
    );

 
    

    BUFG q1_clk1_refclk_bufg_i
    (
        .I                              (q1_clk1_refclk_i),
        .O                              (q1_clk1_refclk_i_bufg)
    );



    //--------------------------------- User Clocks ---------------------------
    
    // The clock resources in this section were added based on userclk source selections on
    // the Latency, Buffering, and Clocking page of the GUI. A few notes about user clocks:
    // * The userclk and userclk2 for each GTX datapath (TX and RX) must be phase aligned to 
    //   avoid data errors in the fabric interface whenever the datapath is wider than 10 bits
    // * To minimize clock resources, you can share clocks between GTXs. GTXs using the same frequency
    //   or multiples of the same frequency can be accomadated using MMCMs. Use caution when
    //   using RXRECCLK as a clock source, however - these clocks can typically only be shared if all
    //   the channels using the clock are receiving data from TX channels that share a reference clock 
    //   source with each other.

    assign  txoutclk_mmcm0_reset_i               =  !gtx0_txplllkdet_i;
    MGT_USRCLK_SOURCE_MMCM #
    (
        .MULT                           (8.0),
        .DIVIDE                         (1),
        .CLK_PERIOD                     (12.5),
        .OUT0_DIVIDE                    (8.0),
        .OUT1_DIVIDE                    (4),
        .OUT2_DIVIDE                    (1),
        .OUT3_DIVIDE                    (1)
    )
    txoutclk_mmcm0_i
    (
        .CLK0_OUT                       (gtx0_txusrclk2_i),
        .CLK1_OUT                       (gtx0_txusrclk_i),
        .CLK2_OUT                       (),
        .CLK3_OUT                       (),
        .CLK_IN                         (gtx0_txoutclk_i),
        .MMCM_LOCKED_OUT                (txoutclk_mmcm0_locked_i),
        .MMCM_RESET_IN                  (txoutclk_mmcm0_reset_i)
    );






    //--------------------------- The GTX Wrapper -----------------------------
    
    // Use the instantiation template in the example directory to add the GTX wrapper to your design.
    // In this example, the wrapper is wired up for basic operation with a frame generator and frame 
    // checker. The GTXs will reset, then attempt to align and transmit data. If channel bonding is 
    // enabled, bonding should occur after alignment.
    
    TRG_TX_BUF_BYPASS #
    (
        .WRAPPER_SIM_GTXRESET_SPEEDUP   (EXAMPLE_SIM_GTXRESET_SPEEDUP)
    )
    trg_tx_buf_bypass_i
    (
        //_____________________________________________________________________
        //_____________________________________________________________________
        //GTX0  (X0Y2)
        //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
        .GTX0_RXN_IN                    (RXN_IN),
        .GTX0_RXP_IN                    (RXP_IN),
        //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
        .GTX0_TXCHARISK_IN              (gtx0_txcharisk_i),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .GTX0_TXDATA_IN                 (gtx0_txdata_i),
        .GTX0_TXOUTCLK_OUT              (gtx0_txoutclk_i),
        .GTX0_TXUSRCLK_IN               (gtx0_txusrclk_i),
        .GTX0_TXUSRCLK2_IN              (gtx0_txusrclk2_i),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .GTX0_TXN_OUT                   (TXN_OUT),
        .GTX0_TXP_OUT                   (TXP_OUT),
        //------ Transmit Ports - TX Elastic Buffer and Phase Alignment Ports ------
        .GTX0_TXDLYALIGNDISABLE_IN      (gtx0_txdlyaligndisable_i),
        .GTX0_TXDLYALIGNMONENB_IN       (gtx0_txdlyalignmonenb_i),
        .GTX0_TXDLYALIGNMONITOR_OUT     (gtx0_txdlyalignmonitor_i),
        .GTX0_TXDLYALIGNRESET_IN        (gtx0_txdlyalignreset_i),
        .GTX0_TXENPMAPHASEALIGN_IN      (gtx0_txenpmaphasealign_i),
        .GTX0_TXPMASETPHASE_IN          (gtx0_txpmasetphase_i),
        //--------------------- Transmit Ports - TX PLL Ports ----------------------
        .GTX0_GTXTXRESET_IN             (gtx0_gtxtxreset_i),
        .GTX0_MGTREFCLKTX_IN            (q1_clk1_refclk_i),
        .GTX0_PLLTXRESET_IN             (gtx0_plltxreset_i),
        .GTX0_TXPLLLKDET_OUT            (gtx0_txplllkdet_i),
        .GTX0_TXRESETDONE_OUT           (gtx0_txresetdone_i)


    );


    //---------------------------- TXSYNC module ------------------------------
    // The TXSYNC module performs phase synchronization for all the active TX datapaths. It
    // waits for the user clocks to be stable, then drives the phase align signals on each
    // GTX. When phase synchronization is complete, it asserts SYNC_DONE
    
    // Include the TX_SYNC module in your own design to perform phase synchronization if
    // your protocol bypasses the TX Buffers
  

    // SIM_TXPMASETPHASE_SPEEDUP is a simulation only attribute and MUST be set to 0 
    // during implementation     
    TX_SYNC #
    (
        .SIM_TXPMASETPHASE_SPEEDUP   (EXAMPLE_SIM_GTXRESET_SPEEDUP)
    )
    gtx0_txsync_i 
    (
        .TXENPMAPHASEALIGN(gtx0_txenpmaphasealign_i),
        .TXPMASETPHASE(gtx0_txpmasetphase_i),
        .TXDLYALIGNDISABLE(gtx0_txdlyaligndisable_i),
        .TXDLYALIGNRESET(gtx0_txdlyalignreset_i),
        .SYNC_DONE(gtx0_tx_sync_done_i),
        .USER_CLK(gtx0_txusrclk2_i),
        .RESET(!gtx0_txresetdone_r2)
    );

    


    //------------------------ User Module Resets -----------------------------
    // All the User Modules i.e. FRAME_GEN, FRAME_CHECK and the sync modules
    // are held in reset till the RESETDONE goes high. 
    // The RESETDONE is registered a couple of times on *USRCLK2 and connected 
    // to the reset of the modules
    
    
    
    always @(posedge gtx0_txusrclk2_i or negedge gtx0_txresetdone_i)

    begin
        if (!gtx0_txresetdone_i)
        begin
            gtx0_txresetdone_r    <=   `DLY 1'b0;
            gtx0_txresetdone_r2   <=   `DLY 1'b0;
        end
        else
        begin
            gtx0_txresetdone_r    <=   `DLY gtx0_txresetdone_i;
            gtx0_txresetdone_r2   <=   `DLY gtx0_txresetdone_r;
        end
    end



    //---------------------------- Frame Generators ---------------------------
    // The example design uses Block RAM based frame generators to provide test
    // data to the GTXs for transmission. By default the frame generators are 
    // loaded with an incrementing data sequence that includes commas/alignment
    // characters for alignment. If your protocol uses channel bonding, the 
    // frame generator will also be preloaded with a channel bonding sequence.
    
    // You can modify the data transmitted by changing the INIT values of the frame
    // generator in this file. Pay careful attention to bit order and the spacing
    // of your control and alignment characters.

    FRAME_GEN #
    (
        .WORDS_IN_BRAM(EXAMPLE_WORDS_IN_BRAM),
        .MEM_00(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_01(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_02(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_03(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_04(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_05(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_06(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_07(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_08(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_09(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_0A(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_0B(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_0C(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_0D(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_0E(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_0F(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_10(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_11(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_12(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_13(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_14(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_15(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_16(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_17(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_18(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_19(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_1A(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_1B(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_1C(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_1D(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_1E(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_1F(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_20(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_21(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_22(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_23(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_24(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_25(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_26(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_27(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_28(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_29(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_2A(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_2B(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_2C(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_2D(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_2E(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_2F(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_30(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_31(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_32(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_33(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_34(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_35(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_36(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_37(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_38(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_39(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_3A(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_3B(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEM_3C(256'h1e1d1c1b1a191817161514131211100f0e0d0c0b0a0908bc0706050403020100),
        .MEM_3D(256'h3e3d3c3b3a393837363534333231302f2e2d2c2b2a292827262524232221201f),
        .MEM_3E(256'h5e5d5c5b5a595857565554535251504f4e4d4c4b4a494847464544434241403f),
        .MEM_3F(256'h7e7d7c7b7a797877767574737271706f6e6d6c6b6a696867666564636261605f),
        .MEMP_00(256'h0000000000000000000000000000010000000000000000000000000000000100),
        .MEMP_01(256'h0000000000000000000000000000010000000000000000000000000000000100),
        .MEMP_02(256'h0000000000000000000000000000010000000000000000000000000000000100),
        .MEMP_03(256'h0000000000000000000000000000010000000000000000000000000000000100),
        .MEMP_04(256'h0000000000000000000000000000010000000000000000000000000000000100),
        .MEMP_05(256'h0000000000000000000000000000010000000000000000000000000000000100),
        .MEMP_06(256'h0000000000000000000000000000010000000000000000000000000000000100),
        .MEMP_07(256'h0000000000000000000000000000010000000000000000000000000000000100)
    )
    gtx0_frame_gen
    (
        // User Interface
        .TX_DATA                        ({gtx0_txdata_float_i,gtx0_txdata_i}),
    
        .TX_CHARISK                     (gtx0_txcharisk_i),
    
        // System Interface
        .USER_CLK                       (gtx0_txusrclk2_i),
        .SYSTEM_RESET                   (gtx0_tx_system_reset_c)
    );


    //-------------------------------- Frame Checkers -------------------------
    // The example design uses Block RAM based frame checkers to verify incoming  
    // data. By default the frame generators are loaded with a data sequence that 
    // matches the outgoing sequence of the frame generators for the TX ports.
    
    // You can modify the expected data sequence by changing the INIT values of the frame
    // checkers in this file. Pay careful attention to bit order and the spacing
    // of your control and alignment characters.
    
    // When the frame checker receives data, it attempts to synchronise to the 
    // incoming pattern by looking for the first sequence in the pattern. Once it 
    // finds the first sequence, it increments through the sequence, and indicates an 
    // error whenever the next value received does not match the expected value.

    
     // This GTX is not active.The match port for pattern checker of this GTX is tied off
     assign gtx0_matchn_i = 1'b0;








    //--------------------------- Chipscope Connections -----------------------
    // When the example design is run in hardware, it uses chipscope to allow the
    // example design and GTX wrapper to be controlled and monitored. The 
    // EXAMPLE_USE_CHIPSCOPE parameter allows chipscope to be removed for simulation.
    
generate
if (EXAMPLE_USE_CHIPSCOPE==1) 
begin : chipscope

    // Shared VIO for all GTXs
    data_vio shared_vio_i
    (
      .control                          (shared_vio_control_i),
      .async_in                         (shared_vio_in_i),
      .async_out                        (shared_vio_out_i),
      .sync_in                          (tied_to_ground_vec_i[31:0]),
      .sync_out                         (),
      .clk                              (tied_to_ground_i)
    );

    // ICON for all VIOs
    icon i_icon
    (
      .control0                         (shared_vio_control_i),
      .control1                         (tx_data_vio_control_i),
      .control2                         (rx_data_vio_control_i),
      .control3                         (ila_control_i)
    );


    // TX VIO
    data_vio tx_data_vio_i
    (
      .control                          (tx_data_vio_control_i),
      .async_in                         (tx_data_vio_async_in_i),
      .async_out                        (tx_data_vio_async_out_i),
      .sync_in                          (tx_data_vio_sync_in_i),
      .sync_out                         (tx_data_vio_sync_out_i),
      .clk                              (gtx0_txusrclk2_i)
    );
    
    // RX VIO
    data_vio rx_data_vio_i
    (
      .control                          (rx_data_vio_control_i),
      .async_in                         (rx_data_vio_async_in_i),
      .async_out                        (rx_data_vio_async_out_i),
      .sync_in                          (rx_data_vio_sync_in_i),
      .sync_out                         (rx_data_vio_sync_out_i),
      .clk                              (gtx0_txusrclk2_i)
    );
    
    // RX ILA
    ila ila_i
    (
      .control                          (ila_control_i),
      .clk                              (gtx0_txusrclk2_i),
      .trig0                            (ila_in_i)
    );




    // assign resets for frame_gen modules
    assign  gtx0_tx_system_reset_c = !gtx0_tx_sync_done_i || user_tx_reset_i;

    // assign resets for frame_check modules

    assign  gtx0_gtxtxreset_i = gtxtxreset_i;

    // Shared VIO Outputs
    assign  gtxtxreset_i                         =  shared_vio_out_i[31];
    assign  user_tx_reset_i                      =  shared_vio_out_i[30];
    assign  user_rx_reset_i                      =  shared_vio_out_i[29];

    // Shared VIO Inputs
    assign  shared_vio_in_i[31:0]                =  32'b00000000000000000000000000000000;

    // Chipscope connections on GTX 0
    assign  gtx0_tx_data_vio_async_in_i[31]      =  gtx0_txplllkdet_i;
    assign  gtx0_tx_data_vio_async_in_i[30]      =  gtx0_txresetdone_i;
    assign  gtx0_tx_data_vio_async_in_i[29:22]   =  gtx0_txdlyalignmonitor_i;
    assign  gtx0_tx_data_vio_async_in_i[21:0]    =  22'b0000000000000000000000;
    assign  gtx0_tx_data_vio_sync_in_i[31:0]     =  32'b00000000000000000000000000000000;
    assign  gtx0_plltxreset_i                    =  tx_data_vio_async_out_i[31];
    assign  gtx0_txdlyalignmonenb_i              =  tx_data_vio_async_out_i[30];
    assign  gtx0_rx_data_vio_async_in_i[31:0]    =  32'b00000000000000000000000000000000;
    assign  gtx0_rx_data_vio_sync_in_i[31:0]     =  32'b00000000000000000000000000000000;
    assign  gtx0_ila_in_i[84:77]                 =  gtx0_error_count_i;
    assign  gtx0_ila_in_i[76:0]                  =  77'b00000000000000000000000000000000000000000000000000000000000000000000000000000;



    assign  tx_data_vio_async_in_i =                       gtx0_tx_data_vio_async_in_i;


    assign  tx_data_vio_sync_in_i =                        gtx0_tx_data_vio_sync_in_i;

    assign  rx_data_vio_async_in_i =                       gtx0_rx_data_vio_async_in_i;


    assign  rx_data_vio_sync_in_i =                        gtx0_rx_data_vio_sync_in_i;


    assign  ila_in_i =                                     gtx0_ila_in_i;

end //end EXAMPLE_USE_CHIPSCOPE=1 generate section
else 
begin: no_chipscope

    // If Chipscope is not being used, drive GTX reset signal
    // from the top level ports
    assign  gtx0_gtxtxreset_i = GTXTXRESET_IN;

    // assign resets for frame_gen modules
    assign  gtx0_tx_system_reset_c = !gtx0_tx_sync_done_i;

    // assign resets for frame_check modules

    assign  gtxtxreset_i                         =  tied_to_ground_i;
    assign  user_tx_reset_i                      =  tied_to_ground_i;
    assign  user_rx_reset_i                      =  tied_to_ground_i;
    assign  gtx0_plltxreset_i                    =  tied_to_ground_i;
    assign  gtx0_txdlyalignmonenb_i              =  tied_to_ground_i;


end
endgenerate //End generate for EXAMPLE_USE_CHIPSCOPE


endmodule

//-------------------------------------------------------------------
//
//  VIO core module declaration
//
//-------------------------------------------------------------------
module data_vio
  (
    control,
    clk,
    async_in,
    async_out,
    sync_in,
    sync_out
  );
  inout  [35:0] control;
  input         clk;
  input  [31:0] async_in;
  output [31:0] async_out;
  input  [31:0] sync_in;
  output [31:0] sync_out;
endmodule


//-------------------------------------------------------------------
//
//  ICON core module declaration
//
//-------------------------------------------------------------------
module icon
  (
      control0,
      control1,
      control2,
      control3
  );
  inout [35:0] control0;
  inout [35:0] control1;
  inout [35:0] control2;
  inout [35:0] control3;
endmodule


//-------------------------------------------------------------------
//
//  ILA core module declaration
//  This is used to allow RX signals to be monitored
//
//-------------------------------------------------------------------
module ila
  (
    control,
    clk,
    trig0
  );
  inout [35:0] control;
  input clk;
  input [84:0] trig0;
endmodule

