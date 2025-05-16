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
Anode : out STD_LOGIC_VECTOR (3 downto 0)); 
end Nano_Processor; 
architecture Behavioral of Nano_Processor is 


------------------------ Program ROM ------------------------ (done)


COMPONENT Program_ROM 
PORT( 
    Memory_Select : in STD_LOGIC_VECTOR (2 downto 0);
    Instruction : out STD_LOGIC_VECTOR (11 downto 0)); 
end COMPONENT; 


-------------------- Instruction Decoder --------------------(done) 

COMPONENT Instruction_Decoder
PORT( 
    Instruction     : in  STD_LOGIC_VECTOR(11 downto 0);  -- 12-bit instruction
    Zero_Flag       : in  STD_LOGIC;                      -- Comes from ALU(Done)
    Reg_Check_Zero  : in STD_LOGIC_VECTOR(3 downto 0);
    Reg_Enable      : out STD_LOGIC_VECTOR(2 downto 0);
    Load_Select     : out STD_LOGIC;
    Immediate       : out STD_LOGIC_VECTOR(3 downto 0);
    MUX_A_Select    : out STD_LOGIC_VECTOR(2 downto 0);
    MUX_B_Select    : out STD_LOGIC_VECTOR(2 downto 0);
    AddSub_Select   : out STD_LOGIC;
    Jump_Flag       : out STD_LOGIC;
    Jump_Address    : out STD_LOGIC_VECTOR(2 downto 0)); 
end COMPONENT;





---------------------- Program Counter ---------------------- (Done)
COMPONENT Program_Counter_3bit 
PORT( Mux_out : in STD_LOGIC_VECTOR (2 downto 0); 
Clk     : in STD_LOGIC; 
Res     : in STD_LOGIC; 
EN      : in STD_LOGIC;
Q       : out STD_LOGIC_VECTOR (2 downto 0)); 
end COMPONENT; 


------------------------ 3-bit Adder ------------------------ (Done)
COMPONENT CLA_3bit 
PORT( A : in STD_LOGIC_VECTOR (2 downto 0);
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
COMPONENT ADD_SUB 
PORT( A : in STD_LOGIC_VECTOR (3 downto 0); 
B : in STD_LOGIC_VECTOR (3 downto 0); 
AddSub_Select : in STD_LOGIC; 
Overflow       : out STD_LOGIC; 
Zero : out STD_LOGIC; 
S    : out STD_LOGIC_VECTOR (3 downto 0)); 
end COMPONENT;



--done-------------------- 8-way 4-bit Mux ---------------------- 
COMPONENT MUX_8_1_4bit 
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
SIGNAL Slw_Clk,OvrFlow,dummy_cout  : STD_LOGIC;                      -- Slow Clock Output 
SIGNAL P_Counter_Out    : STD_LOGIC_VECTOR (2 downto 0);  -- (Q,Memory_Select)
Program_Counter_Output 
SIGNAL ADDER_3_Out      : STD_LOGIC_VECTOR (2 downto 0);  -- 
Send_to_2_way_3_bit_MUX 
SIGNAL MUX_2_1_3bit_Out : STD_LOGIC_VECTOR (2 downto 0);  -- (Mux_out,Y)
Send_to_PROGRAM_COUNTER 
SIGNAL I                : STD_LOGIC_VECTOR (11 downto 0); --(Instruction,Instruction) 
Send_to_PROGRAM_to_Instruction_Decoder 
SIGNAL Reg_Sel_MuxA,Decoder_Val,Reg_Sel_MuxB,Address_JMP : STD_LOGIC_VECTOR (2 
downto 0); 
SIGNAL Im_Value                                          : STD_LOGIC_VECTOR (3 
downto 0); 
SIGNAL Load_Sel,Add_or_Sub,Jmp_Flag ,Zero_Flag                     : STD_LOGIC; 
SIGNAL D_0,D_1,D_2,D_3,D_4,D_5,D_6,D_7,M_A,M_B, M_0,Result : STD_LOGIC_VECTOR (3 
downto 0); 
SIGNAL Zero_Flag                     : STD_LOGIC; -{dummy}

-------------------------- Mapping -------------------------- 
begin 

Slow_Clock : Slow_Clk --(Done)
PORT MAP ( Clk_in => Clk_in, 
Clk_out => Slw_Clk ); 


Program_Counter : Program_Counter_3bit --(Done)
PORT MAP ( Mux_out => MUX_2_1_3bit_Out, 
Clk     => Slw_Clk, 
Res     => Reset, 
EN => '1',
Q       => P_Counter_Out); 

--done
Add_Sub_4bit : ADD_SUB 
PORT MAP ( A => M_A, --switched M_A and M_B 
B => M_B, 
AddSub_Select => Add_or_Sub, 
Overflow       => OvrFlow, 
Zero => Zero, 
S    => Result); 


Adder_3bit : ADDER_3 --(Done)
PORT MAP ( A => P_Counter_Out, 
            B=>"001",
            Cin=>"0",
            Cout=>dummy_cout,

Sum => ADDER_3_Out); 

 
MuX_2_way_3bit : Mux2_3bit --(Done)
PORT MAP ( Sel     => Jmp_Flag, 
           B  => Address_JMP, 
           A  => ADDER_3_Out, 
           Y => MUX_2_1_3bit_Out); 
 
           
Program_ROM : Program_ROM --(done)
PORT MAP ( Memory_Select   => P_Counter_Out, 
           Instruction => I); 
 

           
Instructions_Decoder : Instruction_Decoder --(doone)
PORT MAP ( 
           Instruction => I, 
           Reg_Check_Zero      => M_A, 
           Reg_Enable     => Decoder_Val, 
           Load_Select     => Load_Sel, 
           Immediate      => Im_Value, 
           MUX_A_Select    => Reg_Sel_MuxA, 
           MUX_B_Select    => Reg_Sel_MuxB, 
           AddSub_Select  => Add_or_Sub, 
           Jump_Flag       => Jmp_Flag,
           Zero_Flag       => Zero_Flag,
           Jump_Address    => Address_JMP); 
 

--DONE           
RegisterBank_0 : Register_Bank 
    port map( 
   Value_In => M_0, 
   Clk => Slw_Clk,  
   Reg_En => Decoder_Val,  -- enable pins of the decoder (this will select the respective register) 
   -- following are the input lines for the registers 
   Reset => Reset, -- mapped to the reset button of the whole processor 
   -- outputs from all the registers 
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
MuX_8_way_4bit_A : MUX_8_1_4bit 
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
 
 
--DONE
MuX_8_way_4bit_B : MUX_8_1_4bit 
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
Overflow <= OvrFlow; 
end Behavioral; 

