----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 02:04:02 PM
-- Design Name: 
-- Module Name: Reg_4_B - Behavioral
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

entity Reg_4_B is
    Port ( 
        D     : in  STD_LOGIC_VECTOR(3 downto 0);
        En    : in  STD_LOGIC;
        Clk   : in  STD_LOGIC;
        Reset : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Reg_4_B;

architecture Behavioral of Reg_4_B is
signal CO : STD_LOGIC_VECTOR(3 downto 0) := (others=>'0');

begin

process (Clk, En)
begin
    if rising_edge(Clk) then
        if Reset = '1' then
            CO <= "0000";  -- Synchronous reset
        else
          if En = '1' then
              CO <= D;
          end if;
        end if;
    end if;
end process;
  Q <= CO;

end Behavioral;
