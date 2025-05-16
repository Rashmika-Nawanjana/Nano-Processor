----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 03:27:53 PM
-- Design Name: 
-- Module Name: Program_ROM - Behavioral
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

entity Program_ROM is
    Port ( Memory_Select : in STD_LOGIC_VECTOR (2 downto 0);
           Instruction : out STD_LOGIC_VECTOR (11 downto 0));
end Program_ROM;

architecture Behavioral of Program_ROM is
    type rom_type is array (0 to 7) of std_logic_vector(11 downto 0); 
    signal P_ROM : rom_type := (
        "101000001010",  -- MOVI R1, 10
        "101001000001",  -- MOVI R2, 1
        "010010000000",  -- NEG R2
        "000001010000",  -- ADD R1, R2
        "111000000111",  -- JZR R1, 7
        "110000000011",  -- JZR R0, 3
        "110000000011",  -- Loop/fill instruction (same as line 5)
        "110000000011"   -- Loop/fill instruction (same as line 5)
    );
begin
    Instruction <= P_ROM(to_integer(unsigned(Memory_Select)));
end Behavioral;
