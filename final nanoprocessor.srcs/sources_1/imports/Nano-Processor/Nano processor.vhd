------------------------------------------------------------------------------- 
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
entity Nano_Processor is 
Port ( Reset : in STD_LOGIC; --(Done)
       Clk_in : in STD_LOGIC; 
         Zero : out STD_LOGIC; 
     Overflow : out STD_LOGIC; 
         RLED : out STD_LOGIC_VECTOR (3 downto 0); 
    Seven_Seg_Out : out STD_LOGIC_VECTOR (6 downto 0); 
        Anode : out STD_LOGIC_VECTOR (3 downto 0);
       Clk_Step : in STD_LOGIC;
       Clk_Mode : in STD_LOGIC ); 
end Nano_Processor; 
architecture Behavioral of Nano_Processor is 


------------------------ Program ROM ------------------------ (done)


COMPONENT Program_ROM 
PORT( 
    Memory_Select : in STD_LOGIC_VECTOR (2 downto 0);
    Instruction : out STD_LOGIC_VECTOR (12 downto 0)); 
end COMPONENT; 


-------------------- Instruction Decoder --------------------(done) 

COMPONENT Instruction_Decoder
PORT( 
        Instruction     : in  STD_LOGIC_VECTOR(12 downto 0);  -- 12-bit instruction
        Reg_Check_Zero  : in STD_LOGIC_VECTOR(3 downto 0);
        Reg_Enable      : out STD_LOGIC_VECTOR(2 downto 0);
        Load_Select     : out STD_LOGIC;
        Immediate       : out STD_LOGIC_VECTOR(3 downto 0);
        MUX_A_Select    : out STD_LOGIC_VECTOR(2 downto 0);
        MUX_B_Select    : out STD_LOGIC_VECTOR(2 downto 0);
        AddSub_Select   : out STD_LOGIC;
        Jump_Flag       : out STD_LOGIC;
        Jump_Address    : out STD_LOGIC_VECTOR(2 downto 0);
        Bit_Select    : out STD_LOGIC_VECTOR(1 downto 0);
        Mode       : out STD_LOGIC); 
end COMPONENT;





---------------------- Program Counter ---------------------- (Done)
COMPONENT Program_Counter_3bit 
PORT( Mux_out : in STD_LOGIC_VECTOR (2 downto 0); 
Clk     : in STD_LOGIC; 
Res     : in STD_LOGIC; 
Q       : out STD_LOGIC_VECTOR (2 downto 0));
 
end COMPONENT; 


------------------------ 3-bit Adder ------------------------ (Done)
COMPONENT CLA_3bit 
PORT(       A : in STD_LOGIC_VECTOR (2 downto 0);
        B     : in  STD_LOGIC_VECTOR(2 downto 0);
        Cin   : in  STD_LOGIC;
        Sum   : out STD_LOGIC_VECTOR(2 downto 0);
        Cout  : out STD_LOGIC );
end COMPONENT; 


----------------------- Register Bank ----------------------- (done)
COMPONENT Register_Bank 
Port (  
        Value_In : in STD_LOGIC_VECTOR(3 downto 0);
        Clk      : in STD_LOGIC;
        Reg_En   : in STD_LOGIC_VECTOR(2 downto 0);
        Reset    : in STD_LOGIC;
        R0       : out STD_LOGIC_VECTOR(3 downto 0);
        R1       : out STD_LOGIC_VECTOR(3 downto 0);
        R2       : out STD_LOGIC_VECTOR(3 downto 0);
        R3       : out STD_LOGIC_VECTOR(3 downto 0);
        R4       : out STD_LOGIC_VECTOR(3 downto 0);
        R5       : out STD_LOGIC_VECTOR(3 downto 0);
        R6       : out STD_LOGIC_VECTOR(3 downto 0);
        R7       : out STD_LOGIC_VECTOR(3 downto 0)
    );    
end COMPONENT;


--done------------------ 4-bit Add/Sub Unit -------------------- 
COMPONENT ALU 
PORT(      A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Bit_Select : in STD_LOGIC_VECTOR (1 downto 0);
           AddSub_Select : in STD_LOGIC;
           Mode : in STD_LOGIC;
           F_Out : out STD_LOGIC_VECTOR (3 downto 0);
           Zero : out STD_LOGIC;
           Overflow : out STD_LOGIC); 
end COMPONENT;



--done-------------------- 8-way 4-bit Mux ---------------------- 
COMPONENT MUX_8_W_4_B
PORT( A0 : in STD_LOGIC_VECTOR (3 downto 0); 
A1 : in STD_LOGIC_VECTOR (3 downto 0); 
A2 : in STD_LOGIC_VECTOR (3 downto 0); 
A3 : in STD_LOGIC_VECTOR (3 downto 0); 
A4 : in STD_LOGIC_VECTOR (3 downto 0); 
A5 : in STD_LOGIC_VECTOR (3 downto 0); 
A6 : in STD_LOGIC_VECTOR (3 downto 0); 
A7 : in STD_LOGIC_VECTOR (3 downto 0); 
S : in STD_LOGIC_VECTOR (2 downto 0); 
C_OUT : out STD_LOGIC_VECTOR (3 downto 0)); 
end COMPONENT; 



---------------------- 2-way 3-bit Mux ---------------------- (Done)
COMPONENT Mux2_3bit 
PORT( A : in STD_LOGIC_VECTOR(2 downto 0);  -- Input 0
        B : in STD_LOGIC_VECTOR(2 downto 0);  -- Input 1
        Sel : in STD_LOGIC;                   -- Select line
        Y : out STD_LOGIC_VECTOR(2 downto 0) );
end COMPONENT;


--done-------------------- 2-way 4-bit Mux ---------------------- 
COMPONENT w2_4_MUX 
PORT( Load_Select : in STD_LOGIC; 
Immediate : in STD_LOGIC_VECTOR (3 downto 0); 
S : in STD_LOGIC_VECTOR (3 downto 0); 
Value_In : out STD_LOGIC_VECTOR (3 downto 0)); 
end COMPONENT; 


--done---------------------- Slow Clock ------------------------- 
COMPONENT Slow_Clk 
PORT( Clk_in : in STD_LOGIC; 
Clk_out : out STD_LOGIC); 
end COMPONENT;


--done--------------------- Seven Segment ----------------------- 
COMPONENT LUT_16_7 
PORT( address : in STD_LOGIC_VECTOR (3 downto 0); 
data    : out STD_LOGIC_VECTOR (6 downto 0)); 
end COMPONENT;


-------------------------- SIGNALS -------------------------- 
SIGNAL Slw_Clk : STD_LOGIC;  
SIGNAL Clk_Using : STD_LOGIC;      
SIGNAL dummy_cout  : STD_LOGIC; 
SIGNAL Res  : STD_LOGIC;   
           
SIGNAL P_Counter_Out    : STD_LOGIC_VECTOR (2 downto 0);  
SIGNAL ADDER_3_Out      : STD_LOGIC_VECTOR (2 downto 0);  
SIGNAL MUX_2_1_3bit_Out : STD_LOGIC_VECTOR (2 downto 0);
  
SIGNAL I                : STD_LOGIC_VECTOR (12 downto 0);

SIGNAL Reg_Sel_MuxA  : STD_LOGIC_VECTOR (2 downto 0); 
SIGNAL Reg_Sel_MuxB  : STD_LOGIC_VECTOR (2 downto 0); 
SIGNAL Decoder_Val   : STD_LOGIC_VECTOR (2 downto 0); 
SIGNAL Address_JMP   : STD_LOGIC_VECTOR (2 downto 0); 
SIGNAL Bit_Select_S   : STD_LOGIC_VECTOR (1 downto 0);

SIGNAL Im_Value      : STD_LOGIC_VECTOR (3 downto 0); 
SIGNAL Load_Sel : STD_LOGIC;
SIGNAL Add_or_Sub : STD_LOGIC; 
SIGNAL Jmp_Flag : STD_LOGIC;
SIGNAL Mode_S  : STD_LOGIC;

SIGNAL D_0, D_1, D_2, D_3, D_4, D_5, D_6, D_7, M_A, M_B, M_0, Result : STD_LOGIC_VECTOR (3 downto 0); 


-------------------------- Mapping -------------------------- 
begin 

Clock_type : Process(Clk_Mode, Slw_Clk, Clk_Step)
begin
case Clk_Mode is
  when '1' => Clk_Using <= Clk_Step;
  when '0' => Clk_Using <= Slw_Clk;
  when others => Clk_Using <= Slw_Clk;
end case;
end process;

Res <= Reset;

Slow_Clock : Slow_Clk --(Done)
PORT MAP ( Clk_in => Clk_in, 
          Clk_out => Slw_Clk ); 


Program_Counter : Program_Counter_3bit --(Done)
PORT MAP ( 
    Mux_out => MUX_2_1_3bit_Out, 
    Clk     => Clk_Using, 
    Res     => Res, 
    Q       => P_Counter_Out); 

--done
ALU_Com : ALU 
PORT MAP ( 
               A => M_A, 
               B => M_B, 
   AddSub_Select => Add_or_Sub, 
        Overflow => Overflow, 
            Zero => Zero,
            Mode=> Mode_S,
            F_Out=>Result, 
               Bit_Select => Bit_Select_S); 


Adder_3bit : CLA_3bit --(Done)
PORT MAP ( 
        A => P_Counter_Out, 
        B =>"001",
      Cin =>'0',
     Cout => dummy_cout,

      Sum => ADDER_3_Out); 

 
MuX_2_way_3bit : Mux2_3bit --(Done)
PORT MAP ( Sel => Jmp_Flag, 
           A  => ADDER_3_Out, 
           B  => Address_JMP, 
           Y  => MUX_2_1_3bit_Out); 
 
           
Program_R : Program_ROM --(done)
PORT MAP ( Memory_Select   => P_Counter_Out, 
           Instruction => I); 
 

           
Instructions_Decoder : Instruction_Decoder --(doone)
PORT MAP ( 
           Instruction => I, 
           Reg_Check_Zero => M_A, 
           Reg_Enable     => Decoder_Val, 
           Load_Select    => Load_Sel, 
           Immediate      => Im_Value, 
           MUX_A_Select    => Reg_Sel_MuxA, 
           MUX_B_Select    => Reg_Sel_MuxB, 
           AddSub_Select  =>  Add_or_Sub, 
           Jump_Flag       => Jmp_Flag,
           Mode       => Mode_S,
           Bit_Select       => Bit_Select_S,
           Jump_Address    => Address_JMP); 
 

--DONE           
RegisterBank_0 : Register_Bank 
    port map( 
   Value_In => M_0, 
        Clk => Clk_Using,  
     Reg_En => Decoder_Val,  
      Reset => Res, 
   
   R0 => D_0, 
   R1 => D_1, 
   R2 => D_2, 
   R3 => D_3, 
   R4 => D_4, 
   R5 => D_5, 
   R6 => D_6, 
   R7 => D_7 
); 
 

--DONE
MuX_8_way_4bit_A : MUX_8_W_4_B 
PORT MAP ( A0 => D_0, 
           A1 => D_1, 
           A2 => D_2, 
           A3 => D_3, 
           A4 => D_4, 
           A5 => D_5, 
           A6 => D_6, 
           A7 => D_7, 
           S => Reg_Sel_MuxA, 
           C_OUT => M_A); 
 
 

MuX_8_way_4bit_B : MUX_8_W_4_B 
PORT MAP ( A0 => D_0, 
A1 => D_1, 
A2 => D_2, 
A3 => D_3, 
A4 => D_4, 
A5 => D_5, 
A6 => D_6, 
A7 => D_7, 
S => Reg_Sel_MuxB, 
C_OUT => M_B); 

--DONE
MuX_2_way_4bit : w2_4_MUX 
PORT MAP ( Load_Select => Load_Sel, 
Immediate => Im_Value, 
S => Result, 
Value_In=> M_0); 

--done
Seven_Segment : LUT_16_7 
PORT MAP ( address => D_7, 
data    => Seven_Seg_Out); 

RLED  <= D_7; 
Anode <= "1110"; 
 
end Behavioral; 

