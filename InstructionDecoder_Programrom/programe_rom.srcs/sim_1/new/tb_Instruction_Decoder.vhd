----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 02:05:29 PM
-- Design Name: 
-- Module Name: tb_Instruction_Decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_Instruction_Decoder is
--  Port ( );
end tb_Instruction_Decoder;

architecture Behavioral of tb_Instruction_Decoder is

-- Component Declaration
    component Instruction_Decoder
        Port (
                Instruction     : in  STD_LOGIC_VECTOR(11 downto 0);  -- 12-bit instruction
                Zero_Flag       : in  STD_LOGIC;                      -- Comes from ALU
                Reg_Check_Zero  : in STD_LOGIC_VECTOR(3 downto 0);
                Reg_Enable      : out STD_LOGIC_VECTOR(2 downto 0);
                Load_Select     : out STD_LOGIC;
                Immediate       : out STD_LOGIC_VECTOR(3 downto 0);
                MUX_A_Select    : out STD_LOGIC_VECTOR(2 downto 0);
                MUX_B_Select    : out STD_LOGIC_VECTOR(2 downto 0);
                AddSub_Select   : out STD_LOGIC;
                Jump_Flag       : out STD_LOGIC;
                Jump_Address    : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    -- Signals to connect to the DUT
    signal Instruction     : STD_LOGIC_VECTOR(11 downto 0);
    signal Zero_Flag       : STD_LOGIC := '0';
    signal Reg_Enable      : STD_LOGIC_VECTOR(2 downto 0);
    signal Load_Select     : STD_LOGIC;
    signal Immediate       : STD_LOGIC_VECTOR(3 downto 0);
    signal MUX_A_Select    : STD_LOGIC_VECTOR(2 downto 0);
    signal MUX_B_Select    : STD_LOGIC_VECTOR(2 downto 0);
    signal AddSub_Select   : STD_LOGIC;
    signal Jump_Flag       : STD_LOGIC;
    signal Jump_Address    : STD_LOGIC_VECTOR(2 downto 0);
    signal Reg_Check_Zero  : STD_LOGIC_VECTOR(3 downto 0);
    
begin
-- Instantiate the Unit Under Test (UUT)
    uut: Instruction_Decoder
        port map (
            Instruction     => Instruction,
            Zero_Flag       => Zero_Flag,
            Reg_Enable      => Reg_Enable,
            Load_Select     => Load_Select,
            Immediate       => Immediate,
            MUX_A_Select    => MUX_A_Select,
            MUX_B_Select    => MUX_B_Select,
            AddSub_Select   => AddSub_Select,
            Jump_Flag       => Jump_Flag,
            Jump_Address    => Jump_Address,
            Reg_Check_Zero  => Reg_Check_Zero
        );

    -- Stimulus Process
    stim_proc: process
    begin
        -- Test MOVI R1, 2 => 10 001 000 0010
        Instruction <= "100010000010";
        wait for 100 ns;
        
        -- Test MOVI R2, 1 => 10 010 000 0001
        Instruction <= "100100000001";
        wait for 100 ns;

        -- Test ADD R1, R2 => 00 001 010 0000
        Instruction <= "000010100000";
        wait for 100 ns;

        -- Test NEG R1 => 01 001 000 0000
        Instruction <= "010010000000";
        wait for 100 ns;
        
        -- Test ADD R1, R2 => 00 001 010 0000
        Instruction <= "000010100000";
        wait for 100 ns;

        -- Test JZR R1, 7 => 11 100 000 0111 (Zero_Flag = '1')
        Instruction <= "111000000111";
        Reg_Check_Zero <= "0000";
        Zero_Flag <= '1';
        wait for 100 ns;

        -- Test JZR R1, 7 with Zero_Flag = '0'
        Zero_Flag <= '0';
        wait for 100 ns;

        wait;  -- end of test
    end process;


end Behavioral;
