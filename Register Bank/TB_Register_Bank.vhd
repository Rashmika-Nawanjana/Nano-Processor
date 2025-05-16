----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 09:34:34 PM
-- Design Name: 
-- Module Name: TB_Register_Bank - Behavioral
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
entity TB_Register_Bank is
-- No ports for testbench
end TB_Register_Bank;

architecture Behavioral of TB_Register_Bank is

    component Register_Bank
        Port (
            Value_In : in  STD_LOGIC_VECTOR(3 downto 0);
            Clk      : in  STD_LOGIC;
            Reg_En   : in  STD_LOGIC_VECTOR(2 downto 0);
            Reset    : in  STD_LOGIC;
            R0       : out STD_LOGIC_VECTOR(3 downto 0);
            R1       : out STD_LOGIC_VECTOR(3 downto 0);
            R2       : out STD_LOGIC_VECTOR(3 downto 0);
            R3       : out STD_LOGIC_VECTOR(3 downto 0);
            R4       : out STD_LOGIC_VECTOR(3 downto 0);
            R5       : out STD_LOGIC_VECTOR(3 downto 0);
            R6       : out STD_LOGIC_VECTOR(3 downto 0);
            R7       : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal input    : STD_LOGIC_VECTOR(3 downto 0);
    signal clk      : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    signal selecter : STD_LOGIC_VECTOR(2 downto 0);
    signal Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7 : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: Register_Bank
        port map (
            Value_In => input,
            Clk      => clk,
            Reg_En   => selecter,
            Reset    => reset,
            R0       => Q0,
            R1       => Q1,
            R2       => Q2,
            R3       => Q3,
            R4       => Q4,
            R5       => Q5,
            R6       => Q6,
            R7       => Q7
        );

    -- Clock generation process (10 ns period)
    process
    begin
        Clk <= NOT Clk;
        wait for 5 ns;
    end process;

    -- Stimulus process
    process
    begin
        reset <= '1';
        wait for 5 ns;
        reset <= '0';

        selecter <= "000";
        wait for 10 ns;
        input <= "0101"; -- 5
        wait for 100 ns;

        selecter <= "001";
        wait for 10 ns;
        input <= "0011"; -- 3
        wait for 100 ns;

        selecter <= "010";
        wait for 10 ns;
        input <= "1111"; -- F
        wait for 100 ns;

        selecter <= "011";
        wait for 5 ns;
        input <= "0111"; -- 7
        wait for 100 ns;

        selecter <= "100";
        wait for 10 ns;
        input <= "0000"; -- 0
        wait for 100 ns;

        selecter <= "101";
        wait for 10 ns;
        input <= "1000"; -- 8
        wait for 100 ns;

        selecter <= "110";
        wait for 10 ns;
        input <= "1100"; -- C
        wait for 100 ns;

        selecter <= "111";
        wait for 10 ns;
        input <= "1101"; -- D
        wait for 100 ns;

        reset <= '1';
        wait;
    end process;

end Behavioral;
