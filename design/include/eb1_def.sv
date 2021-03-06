// performance monitor stuff
//`ifndef eb1_DEF_SV
//`define eb1_DEF_SV
package eb1_pkg;

typedef struct packed {
                       logic  trace_rv_i_valid_ip;
                       logic [31:0] trace_rv_i_insn_ip;
                       logic [31:0] trace_rv_i_address_ip;
                       logic  trace_rv_i_exception_ip;
                       logic [4:0] trace_rv_i_ecause_ip;
                       logic  trace_rv_i_interrupt_ip;
                       logic [31:0] trace_rv_i_tval_ip;
                       } eb1_trace_pkt_t;


typedef enum logic [3:0] {
                          NULL     = 4'b0000,
                          MUL      = 4'b0001,
                          LOAD     = 4'b0010,
                          STORE    = 4'b0011,
                          ALU      = 4'b0100,
                          CSRREAD  = 4'b0101,
                          CSRWRITE = 4'b0110,
                          CSRRW    = 4'b0111,
                          EBREAK   = 4'b1000,
                          ECALL    = 4'b1001,
                          FENCE    = 4'b1010,
                          FENCEI   = 4'b1011,
                          MRET     = 4'b1100,
                          CONDBR   = 4'b1101,
                          JAL      = 4'b1110,
                          BITMANIPU = 4'b1111
                          } eb1_inst_pkt_t;

typedef struct packed {
                       logic valid;
                       logic wb;
                       logic [2:0] tag;
                       logic [4:0] rd;
                       } eb1_load_cam_pkt_t;

typedef struct packed {
                       logic pc0_call;
                       logic pc0_ret;
                       logic pc0_pc4;
                       } eb1_rets_pkt_t;
typedef struct packed {
                       logic valid;
                       logic [11:0] toffset;
                       logic [1:0] hist;
                       logic br_error;
                       logic br_start_error;
                       logic  bank;
                       logic [31:1] prett;  // predicted ret target
                       logic way;
                       logic ret;
                       } eb1_br_pkt_t;

typedef struct packed {
                       logic valid;
                       logic [1:0] hist;
                       logic br_error;
                       logic br_start_error;
                       logic way;
                       logic middle;
                       } eb1_br_tlu_pkt_t;

typedef struct packed {
                       logic misp;
                       logic ataken;
                       logic boffset;
                       logic pc4;
                       logic [1:0] hist;
                       logic [11:0] toffset;
                       logic valid;
                       logic br_error;
                       logic br_start_error;
                       logic pcall;
                       logic pja;
                       logic way;
                       logic pret;
                       // for power use the pret bit to clock the prett field
                       logic [31:1] prett;
                       } eb1_predict_pkt_t;

typedef struct packed {
                       // unlikely to change
                       logic icaf;
                       logic icaf_second;
                       logic [1:0] icaf_type;
                       logic fence_i;
                       logic [3:0] i0trigger;
                       logic pmu_i0_br_unpred;     // pmu
                       logic pmu_divide;
                       // likely to change
                       logic legal;
                       logic pmu_lsu_misaligned;
                       eb1_inst_pkt_t pmu_i0_itype;        // pmu - instruction type
                       } eb1_trap_pkt_t;

typedef struct packed {
                       // unlikely to change
                       logic i0div;
                       logic csrwen;
                       logic csrwonly;
                       logic [11:0] csrwaddr;
                       // likely to change
                       logic [4:0] i0rd;
                       logic i0load;
                       logic i0store;
                       logic i0v;
                       logic i0valid;
                       } eb1_dest_pkt_t;

typedef struct packed {
                       logic mul;
                       logic load;
                       logic alu;
                       } eb1_class_pkt_t;

typedef struct packed {
                       logic [4:0] rs1;
                       logic [4:0] rs2;
                       logic [4:0] rd;
                       } eb1_reg_pkt_t;


typedef struct packed {
                       logic clz;
                       logic ctz;
                       logic pcnt;
                       logic sext_b;
                       logic sext_h;
                       logic slo;
                       logic sro;
                       logic min;
                       logic max;
                       logic pack;
                       logic packu;
                       logic packh;
                       logic rol;
                       logic ror;
                       logic grev;
                       logic gorc;
                       logic zbb;
                       logic sbset;
                       logic sbclr;
                       logic sbinv;
                       logic sbext;
                       logic sh1add;
                       logic sh2add;
                       logic sh3add;
                       logic zba;
                       logic land;
                       logic lor;
                       logic lxor;
                       logic sll;
                       logic srl;
                       logic sra;
                       logic beq;
                       logic bne;
                       logic blt;
                       logic bge;
                       logic add;
                       logic sub;
                       logic slt;
                       logic unsign;
                       logic jal;
                       logic predict_t;
                       logic predict_nt;
                       logic csr_write;
                       logic csr_imm;
                       } eb1_alu_pkt_t;

typedef struct packed {
                       logic fast_int;
/* verilator lint_off SYMRSVDWORD */
                       logic stack;
/* verilator lint_on SYMRSVDWORD */
                       logic by;
                       logic half;
                       logic word;
                       logic dword;  // for dma
                       logic load;
                       logic store;
                       logic unsign;
                       logic dma;    // dma pkt
                       logic store_data_bypass_d;
                       logic load_ldst_bypass_d;
                       logic store_data_bypass_m;
                       logic valid;
                       } eb1_lsu_pkt_t;

typedef struct packed {
                      logic inst_type;   //0: Load, 1: Store
                      //logic dma_valid;
                      logic exc_type;    //0: MisAligned, 1: Access Fault
                      logic [3:0] mscause;
                      logic [31:0] addr;
                      logic single_ecc_error;
                      logic exc_valid;
                      } eb1_lsu_error_pkt_t;

typedef struct packed {
                       logic clz;
                       logic ctz;
                       logic pcnt;
                       logic sext_b;
                       logic sext_h;
                       logic slo;
                       logic sro;
                       logic min;
                       logic max;
                       logic pack;
                       logic packu;
                       logic packh;
                       logic rol;
                       logic ror;
                       logic grev;
                       logic gorc;
                       logic zbb;
                       logic sbset;
                       logic sbclr;
                       logic sbinv;
                       logic sbext;
                       logic zbs;
                       logic bext;
                       logic bdep;
                       logic zbe;
                       logic clmul;
                       logic clmulh;
                       logic clmulr;
                       logic zbc;
                       logic shfl;
                       logic unshfl;
                       logic zbp;
                       logic crc32_b;
                       logic crc32_h;
                       logic crc32_w;
                       logic crc32c_b;
                       logic crc32c_h;
                       logic crc32c_w;
                       logic zbr;
                       logic bfp;
                       logic zbf;
                       logic sh1add;
                       logic sh2add;
                       logic sh3add;
                       logic zba;
                       logic alu;
                       logic rs1;
                       logic rs2;
                       logic imm12;
                       logic rd;
                       logic shimm5;
                       logic imm20;
                       logic pc;
                       logic load;
                       logic store;
                       logic lsu;
                       logic add;
                       logic sub;
                       logic land;
                       logic lor;
                       logic lxor;
                       logic sll;
                       logic sra;
                       logic srl;
                       logic slt;
                       logic unsign;
                       logic condbr;
                       logic beq;
                       logic bne;
                       logic bge;
                       logic blt;
                       logic jal;
                       logic by;
                       logic half;
                       logic word;
                       logic csr_read;
                       logic csr_clr;
                       logic csr_set;
                       logic csr_write;
                       logic csr_imm;
                       logic presync;
                       logic postsync;
                       logic ebreak;
                       logic ecall;
                       logic mret;
                       logic mul;
                       logic rs1_sign;
                       logic rs2_sign;
                       logic low;
                       logic div;
                       logic rem;
                       logic fence;
                       logic fence_i;
                       logic pm_alu;
                       logic legal;
                       } eb1_dec_pkt_t;


typedef struct packed {
                       logic valid;
                       logic rs1_sign;
                       logic rs2_sign;
                       logic low;
                       logic bext;
                       logic bdep;
                       logic clmul;
                       logic clmulh;
                       logic clmulr;
                       logic grev;
                       logic gorc;
                       logic shfl;
                       logic unshfl;
                       logic crc32_b;
                       logic crc32_h;
                       logic crc32_w;
                       logic crc32c_b;
                       logic crc32c_h;
                       logic crc32c_w;
                       logic bfp;
                       } eb1_mul_pkt_t;

typedef struct packed {
                       logic valid;
                       logic unsign;
                       logic rem;
                       } eb1_div_pkt_t;

typedef struct packed {
                       logic        TEST1;
                       logic        RME;
                       logic [3:0]  RM;

                       logic        LS;
                       logic        DS;
                       logic        SD;
                       logic        TEST_RNM;
                       logic        BC1;
                       logic        BC2;
                      } eb1_ccm_ext_in_pkt_t;

typedef struct packed {
                       logic        TEST1;
                       logic        RME;
                       logic [3:0]  RM;
                       logic        LS;
                       logic        DS;
                       logic        SD;
                       logic        TEST_RNM;
                       logic        BC1;
                       logic        BC2;
                      } eb1_dccm_ext_in_pkt_t;


typedef struct packed {
                       logic        TEST1;
                       logic        RME;
                       logic [3:0]  RM;
                       logic        LS;
                       logic        DS;
                       logic        SD;
                       logic        TEST_RNM;
                       logic        BC1;
                       logic        BC2;
                      } eb1_ic_data_ext_in_pkt_t;


typedef struct packed {
                       logic        TEST1;
                       logic        RME;
                       logic [3:0]  RM;
                       logic        LS;
                       logic        DS;
                       logic        SD;
                       logic        TEST_RNM;
                       logic        BC1;
                       logic        BC2;
                      } eb1_ic_tag_ext_in_pkt_t;



typedef struct packed {
                        logic        select;
                        logic        match;
                        logic        store;
                        logic        load;
                        logic        execute;
                        logic        m;
                        logic [31:0] tdata2;
            } eb1_trigger_pkt_t;


typedef struct packed {
                        logic [70:0]  icache_wrdata; // {dicad1[1:0], dicad0h[31:0], dicad0[31:0]}
                        logic [16:0]  icache_dicawics; // Arraysel:24, Waysel:21:20, Index:16:3
                        logic         icache_rd_valid;
                        logic         icache_wr_valid;
            } eb1_cache_debug_pkt_t;
//`endif

endpackage // eb1_pkg
