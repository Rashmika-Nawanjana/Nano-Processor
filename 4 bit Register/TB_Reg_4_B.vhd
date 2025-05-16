----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 07:37:01 PM
-- Design Name: 
-- Module Name: TB_Reg_4_B - Behavioral
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

entity TB_Reg_4_B is
    -- No ports for a testbench
end TB_Reg_4_B;

architecture Behavioral of TB_Reg_4_B is

    -- Component declaration for the Unit Under Test (UUT)
    component Reg_4_B is
        Port ( 
            D     : in  STD_LOGIC_VECTOR(3 downto 0);
            En    : in  STD_LOGIC;
            Clk   : in  STD_LOGIC;
            Reset : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Testbench signals
    signal Clk, En, Rst : STD_LOGIC;
    signal D            : STD_LOGIC_VECTOR(3 downto 0);
    signal Q            : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: Reg_4_B 
        port map (
            Clk   => Clk,
            Reset => Rst,
            En    => En,
            D     => D,
            Q     => Q
        );

    -- Clock generation process (10ns period)
    clock_process: process
    begin
        while true loop
            Clk <= '0';
            wait for 5 ns;
            Clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulus process to test behavior
    reg_process: process
    begin
        -- Apply asynchronous reset
        Rst <= '1';
        En  <= '0';
        D   <= "0111";
        wait for 100 ns;

        -- Release reset, don't write yet
        Rst <= '0';
        D   <= "1111";
        wait for 100 ns;

        -- Enable write and allow storing of "1111"
        En  <= '1';
        wait for 10 ns;

        -- Change data to "0011", should be stored on next clock
        D   <= "0011";
        wait for 100 ns;

        -- Reset the register again
        Rst <= '1';
        wait for 100 ns;

        -- Release reset and load new data
        Rst <= '0';
        D   <= "0101";
        wait for 100 ns;

        -- End of simulation
        wait;
    end process;

end Behavioral;

