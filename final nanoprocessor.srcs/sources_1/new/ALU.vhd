----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/23/2025 07:00:41 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Bit_Select : in STD_LOGIC_VECTOR (1 downto 0);
           AddSub_Select : in STD_LOGIC;
           Mode : in STD_LOGIC;
           F_Out : out STD_LOGIC_VECTOR (3 downto 0);
           Zero : out STD_LOGIC;
           Overflow : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

COMPONENT ADD_SUB
PORT( 
          A : in STD_LOGIC_VECTOR (3 downto 0);
          B : in STD_LOGIC_VECTOR (3 downto 0);
          AddSub_Select : in STD_LOGIC;
          Overflow : out STD_LOGIC;
          Zero : out STD_LOGIC;
          S : out STD_LOGIC_VECTOR (3 downto 0)); 
end COMPONENT;


COMPONENT Bitwise_operator
PORT( 
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Bit_Select : in STD_LOGIC_VECTOR (1 downto 0);
           Bit_Out : out STD_LOGIC_VECTOR (3 downto 0)); 
end COMPONENT;
 

SIGNAL AddSub_Select_S  : STD_LOGIC; 
SIGNAL Mode_S  : STD_LOGIC; 
SIGNAL Overflow_S  : STD_LOGIC; 
SIGNAL Zero_S  : STD_LOGIC; 

  
           
SIGNAL A_S    : STD_LOGIC_VECTOR (3 downto 0);  
SIGNAL B_S     : STD_LOGIC_VECTOR (3 downto 0);  
SIGNAL Bit_Select_S : STD_LOGIC_VECTOR (1 downto 0);
SIGNAL S_S    : STD_LOGIC_VECTOR (3 downto 0); 
SIGNAL Bit_Out_S    : STD_LOGIC_VECTOR (3 downto 0); 

  
begin

A_S <= A;
B_S <= B;
Bit_Select_S <= Bit_Select;
Mode_S <= Mode;
AddSub_Select_S <= AddSub_Select;
Zero <= Zero_S;
Overflow <= Overflow_S;  


ADD_SUB_Com :ADD_SUB --(Done)
PORT MAP ( A => A_S, 
           B  => B_S, 
           AddSub_Select  => AddSub_Select_S, 
           Overflow  => Overflow_S,
           Zero  => Zero_S,
           S  => S_S); 
           
 

Bitwise_operator_Com :Bitwise_operator --(Done)
PORT MAP ( A => A_S, 
           B  => B_S, 
           Bit_Select  => Bit_Select_S, 
           Bit_Out  => Bit_Out_S);
           
--selector           
process(S_S,Bit_Out_S)
begin
   case Mode_S  is
      when '0' =>   --compliment
            F_Out <= S_S;
                          
      when '1' =>   --compliment
            F_Out <= Bit_Out_S;
                                                  
      when others =>
            F_Out <= (others => '0');     


   end case;
end process; 
           
           
                   
        
           
end Behavioral;
