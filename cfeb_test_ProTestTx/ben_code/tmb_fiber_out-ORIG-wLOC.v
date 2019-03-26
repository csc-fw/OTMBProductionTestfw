`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:36:50 08/05/2011 
// Design Name: 
// Module Name:    tmb_fiber_out 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module tmb_fiber_out #(
	parameter SIM_SPEEDUP = 0
)
(
	input RST,        // use reset
	input TRG_SIGDET, // ??
	input TRG_RX_N,
	input TRG_RX_P,
	output TRG_TDIS,  // N/A
	output TRG_TX_N,
	output TRG_TX_P,
	input [7:0] G1C,  // I guess these are the Comp. data to send...from PRBS?
	input [7:0] G2C,  // if ENA_TEST_PAT then it's prbs, so these don't matter
	input [7:0] G3C,
	input [7:0] G4C,
	input [7:0] G5C,
	input [7:0] G6C,
	input TRG_TX_REFCLK, // RefClk?  I have 160...
	input TRG_TXUSRCLK,  // Use my 160?
	input TRG_CLK80,     // RefClk?  I have 160...
	input TRG_GTXTXRST,  // use reset
	input TRG_TX_PLLRST, // use !rxpll_lock ?
	input TRG_RST,       // use reset ?
	input ENA_TEST_PAT,  // HIGH for PRBS!  (Low will send data from GxC registers)
	input INJ_ERR,       // use my switch/PB combo logic for this, high-true?
	output TRG_SD,
	output TRG_TXOUTCLK,
	output TRG_TX_PLL_LOCK,
	output TRG_TXRESETDONE,
	output TX_SYNC_DONE,
	output STRT_LTNCY,
	output reg LTNCY_TRIG,
	output MON_TX_SEL,
	output [3:0] MON_TRG_TX_ISK,
	output [31:0] MON_TRG_TX_DATA
	);
	

wire trg_tx_dis;

//Inputs to TRG GTX transmitter
wire [3:0] trg_tx_isk;
wire [31:0] trg_tx_data;
wire tx_dlyaligndisable;
wire tx_dlyalignreset;
wire tx_enpmaphasealign;
wire tx_pmasetphase;
reg trg_txresetdone_r;
reg trg_txresetdone_r2;
wire [7:0] tx_dly_align_mon;
wire tx_dly_align_mon_ena;
reg [15:0] frm_sep;
reg [7:0] trgcnt;
reg lt_trg;
reg rst_tx;


//PRBS signals
wire [47:0] prbs;
wire [47:0] comp_data;
wire [47:0] out_data;
reg  tx_sel;
reg  tx_sel_bar;
wire prbs_rst;
reg p_rst1,p_rst2,p_rst3,p_rst4;
reg p_rst5,p_rst6,p_rst7,p_rst8;

assign MON_TX_SEL      = tx_sel;
assign MON_TRG_TX_ISK  = trg_tx_isk;
assign MON_TRG_TX_DATA = trg_tx_data;
assign trg_tx_dis =1'b0;
assign tx_dly_align_mon_ena = 1'b0;

IBUF IBUF_TRG_SIGDET (.O(TRG_SD),.I(TRG_SIGDET));
OBUF  #(.DRIVE(12),.IOSTANDARD("DEFAULT"),.SLEW("SLOW")) OBUF_TRG_TDIS (.O(TRG_TDIS),.I(trg_tx_dis));


	 (* LOC = "GTXE1_X0Y2" *)
	 TRG_TX_BUF_BYPASS #
	 (
		  .WRAPPER_SIM_GTXRESET_SPEEDUP   (SIM_SPEEDUP)      // Set this to 1 for simulation
	 )
	 trg_tx_buf_bypass_i
	 (
		  //_____________________________________________________________________
		  //_____________________________________________________________________
		  //GTX0  (X0Y13)

		  //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
		  .GTX0_RXN_IN                    (),
		  .GTX0_RXP_IN                    (),
		  //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
		  .GTX0_TXCHARISK_IN              (trg_tx_isk),
		  //---------------- Transmit Ports - TX Data Path interface -----------------
		  .GTX0_TXDATA_IN                 (trg_tx_data),
		  .GTX0_TXOUTCLK_OUT              (TRG_TXOUTCLK),
		  .GTX0_TXUSRCLK_IN               (TRG_TXUSRCLK),
		  .GTX0_TXUSRCLK2_IN              (TRG_CLK80),
		  //-------------- Transmit Ports - TX Driver and OOB signaling --------------
		  .GTX0_TXN_OUT                   (TRG_TX_N),
		  .GTX0_TXP_OUT                   (TRG_TX_P),
		  //------ Transmit Ports - TX Elastic Buffer and Phase Alignment Ports ------
		  .GTX0_TXDLYALIGNDISABLE_IN      (tx_dlyaligndisable),
		  .GTX0_TXDLYALIGNMONENB_IN       (tx_dly_align_mon_ena),
		  .GTX0_TXDLYALIGNMONITOR_OUT     (tx_dly_align_mon),
		  .GTX0_TXDLYALIGNRESET_IN        (tx_dlyalignreset),
		  .GTX0_TXENPMAPHASEALIGN_IN      (tx_enpmaphasealign),
		  .GTX0_TXPMASETPHASE_IN          (tx_pmasetphase),
		  //--------------------- Transmit Ports - TX PLL Ports ----------------------
		  .GTX0_GTXTXRESET_IN             (TRG_GTXTXRST),
		  .GTX0_MGTREFCLKTX_IN            (TRG_TX_REFCLK),
		  .GTX0_PLLTXRESET_IN             (TRG_TX_PLLRST),
		  .GTX0_TXPLLLKDET_OUT            (TRG_TX_PLL_LOCK),
		  .GTX0_TXRESETDONE_OUT           (TRG_TXRESETDONE)
	 );

	 //---------------------------- TXSYNC module ------------------------------
	 // Since you are bypassing the TX Buffer in your wrapper, you will need to drive
	 // the phase alignment ports to align the phase of the TX Datapath. Include
	 // this module in your design to have phase alignment performed automatically as
	 // it is done in the example design.


	always @(posedge TRG_CLK80 or negedge TRG_TXRESETDONE) begin
		if(!TRG_TXRESETDONE) begin
			trg_txresetdone_r  <= 1'b0;
			trg_txresetdone_r2 <= 1'b0;
		end
		else begin
			trg_txresetdone_r  <= TRG_TXRESETDONE;
			trg_txresetdone_r2 <= trg_txresetdone_r;
		end
	end
		  
	 TX_SYNC #(
		  .SIM_TXPMASETPHASE_SPEEDUP   (SIM_SPEEDUP)
	 )
	 gtx0_txsync_i (
		  .TXENPMAPHASEALIGN  (tx_enpmaphasealign),      
		  .TXPMASETPHASE      (tx_pmasetphase),
		  .TXDLYALIGNDISABLE  (tx_dlyaligndisable),
		  .TXDLYALIGNRESET    (tx_dlyalignreset),
		  .SYNC_DONE          (TX_SYNC_DONE),
		  .USER_CLK           (TRG_CLK80),
		  .RESET              (!trg_txresetdone_r2)
	 );

//
// Transmit data
//  

	assign comp_data = {G6C,G5C,G4C,G3C,G2C,G1C};
        assign out_data = ENA_TEST_PAT ? prbs : comp_data;
	assign trg_tx_data = rst_tx ? 32'h50BC50BC : (tx_sel ? out_data[47:16] : {out_data[15:0],frm_sep});
	assign trg_tx_isk  = rst_tx ?  4'b0101 :     (tx_sel ?               4'b0000     :  4'b0001);

	always @(posedge TRG_CLK80) begin
		rst_tx <= TRG_RST;
		LTNCY_TRIG <= lt_trg;
	end
	always @(posedge TRG_CLK80 or posedge TRG_RST) begin
		if(TRG_RST) begin
			tx_sel <= 1'b1;
			tx_sel_bar <= 1'b1;
		end
		else begin
			tx_sel <= ~tx_sel;
			tx_sel_bar <= tx_sel;
		end
	end
	always @(posedge TRG_CLK80 or posedge rst_tx) begin
		if(rst_tx) begin
			trgcnt <= 8'h00;
		end
		else begin
			trgcnt <= trgcnt + 1;
		end
	end
	always @* begin
		if(!rst_tx && (trgcnt==8'h00)) begin
			frm_sep = 16'h50FC;
			lt_trg = 1'b1;
		end
		else begin
			frm_sep = 16'h50BC;
			lt_trg = 1'b0;
		end
	end
	

//
// Test pattern reset
//  
	assign prbs_rst    = TRG_RST | p_rst1 | p_rst2 | p_rst3 | p_rst4 | p_rst5 | p_rst6 | p_rst7 | p_rst8;
	always @(posedge TRG_CLK80) begin
		if(tx_sel_bar) begin
			p_rst1 <= TRG_RST;
			p_rst2 <= p_rst1;
			p_rst3 <= p_rst2;
			p_rst4 <= p_rst3;
			p_rst5 <= p_rst4;
			p_rst6 <= p_rst5;
			p_rst7 <= p_rst6;
			p_rst8 <= p_rst7;
		end
	end


//
// Pseudo Random Bit Stream
//

	PRBS_tx #(.start_pattern(48'hFFFFFF000000))
	tx1 (
		.OUT_CLK_ENA(tx_sel), 
		.GEN_CLK(TRG_CLK80), 
		.RST(prbs_rst),
		.INJ_ERR(INJ_ERR),
		.PRBS(prbs),
		.STRT_LTNCY(STRT_LTNCY)
	);

endmodule
