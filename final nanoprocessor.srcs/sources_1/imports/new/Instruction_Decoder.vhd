----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 11:28:18 AM
-- Design Name: 
-- Module Name: Instruction_Decoder - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_Decoder is
    Port (
        Instruction     : in  STD_LOGIC_VECTOR(12 downto 0);  -- 13-bit instruction
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
        Mode       : out STD_LOGIC
    );
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is
   signal opcode : STD_LOGIC_VECTOR(2 downto 0);
begin
 opcode <= Instruction(12 downto 10);
 process(opcode, Instruction, Reg_Check_Zero)
 begin
     -- Default outputs
     Reg_Enable       <= (others => '0');
     MUX_A_Select       <= (others => '0');
     MUX_B_Select       <= (others => '0');
     Load_Select     <= '0';
     Immediate      <= (others => '0');
     AddSub_Select         <= '0';
     Mode         <= '0';
     Jump_Flag    <= '0';
     Jump_Address <= (others => '0');
     case opcode is
         when "000" =>  -- ADD
             Reg_Enable <= Instruction(9 downto 7);
             MUX_A_Select <= Instruction(9 downto 7);
             MUX_B_Select <= Instruction(6 downto 4);
         when "001" =>  -- NEG
             Reg_Enable <= Instruction(9 downto 7);
             MUX_B_Select <= Instruction(9 downto 7);
             AddSub_Select   <= '1';
         when "010" =>  -- MOVI
             Reg_Enable   <= Instruction(9 downto 7);
             Load_Select <= '1';
             Immediate  <= Instruction(3 downto 0);
         when "011" =>  -- JZR
             MUX_A_Select       <= Instruction(9 downto 7);
             Jump_Address <= Instruction(2 downto 0);
             if Reg_Check_Zero = "0000" then
                 Jump_Flag <= '1';
             end if;
             
             
             
             
         when "100" =>  -- Bit complement
              Reg_Enable   <= Instruction(9 downto 7);
              MUX_B_Select <= Instruction(9 downto 7);
              Bit_Select <="00";
              Mode <='1'; 
         when "101" =>  -- Bit And
              Reg_Enable   <= Instruction(9 downto 7);
              MUX_A_Select <= Instruction(9 downto 7);
              MUX_B_Select <= Instruction(6 downto 4);
              Bit_Select <="01";
              Mode <='1';         
         when "110" =>  -- Bit Or
              Reg_Enable   <= Instruction(9 downto 7);
              MUX_A_Select <= Instruction(9 downto 7);
              MUX_B_Select <= Instruction(6 downto 4);
              Bit_Select <="10";
              Mode <='1';
         when "111" =>  -- Bit Xor
              Reg_Enable   <= Instruction(9 downto 7);
              MUX_A_Select <= Instruction(9 downto 7);
              MUX_B_Select <= Instruction(6 downto 4);
              Bit_Select <="11";
              Mode <='1';                        

         when others =>
         null;
     end case;
 end process;
end Behavioral;



