----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 01:33:49 PM
-- Design Name: 
-- Module Name: tb_Program_ROM - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_Program_ROM is
--  Port ( );
end tb_Program_ROM;

architecture Behavioral of tb_Program_ROM is
-- Component declaration of the ROM under test
    component Program_ROM
        Port (
            Memory_Select : in  STD_LOGIC_VECTOR(2 downto 0);
            Instruction    : out STD_LOGIC_VECTOR(11 downto 0)
        );
    end component;

    -- Testbench signals
    signal Memory_Select : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal Instruction    : STD_LOGIC_VECTOR(11 downto 0);

begin
-- Instantiate the ROM module
    UUT: Program_ROM
        port map (
            Memory_Select => Memory_Select,
            Instruction    => Instruction
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Loop through all 8 memory locations
        for i in 0 to 7 loop
            Memory_Select <= std_logic_vector(to_unsigned(i, 3));
            wait for 100 ns;  -- wait to observe output
        end loop;

        wait; -- wait forever, simulation ends here
    end process;


end Behavioral;
