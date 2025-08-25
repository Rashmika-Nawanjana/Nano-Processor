----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/23/2025 05:10:09 PM
-- Design Name: 
-- Module Name: Bitwise_operator - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Bitwise_operator is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Bit_Select : in STD_LOGIC_VECTOR (1 downto 0);
           Bit_Out : out STD_LOGIC_VECTOR (3 downto 0));
end Bitwise_operator;


architecture Behavioral of Bitwise_operator is

begin
process(A,B,Bit_Select)
begin
    case Bit_Select  is
       when "00" =>   --compliment
             Bit_Out <= Not B ;
                           
       when "01" =>  --and
            Bit_Out <= A and B;
            
       when "10" =>  --or
            Bit_Out <= A or B;
            
       when "11" =>  --xor
            Bit_Out <= A xor B;     
            
       when others =>
            Bit_Out <= (others => '0');  -- or assign to A, or keep last value if desired


    end case;
end process;
    

end Behavioral;