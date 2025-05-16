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
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is
    signal opcode : STD_LOGIC_VECTOR(1 downto 0);
    signal Ra, Rb : STD_LOGIC_VECTOR(2 downto 0);

begin
    process(Instruction, Zero_Flag)
        variable opcode : STD_LOGIC_VECTOR(1 downto 0);
        variable Ra, Rb : STD_LOGIC_VECTOR(2 downto 0);
    begin
        opcode := Instruction(11 downto 10);
        Ra     := Instruction(9 downto 7);
        Rb     := Instruction(6 downto 4);
        -- Default values
        Reg_Enable      <= (others => '0');
        Load_Select     <= '0';
        Immediate       <= Instruction(3 downto 0);
        MUX_A_Select    <= Ra;
        MUX_B_Select    <= Rb;
        AddSub_Select   <= '0';
        Jump_Flag       <= '0';
        Jump_Address    <= Instruction(2 downto 0);
        
        
        case opcode is
                    when "10" =>  -- MOVI
                        Load_Select <= '1';  -- use immediate
                        Reg_Enable <= Ra;
        
                    when "00" =>  -- ADD
                        MUX_A_Select <= Ra; -- R0 (zero)
                        MUX_B_Select <= Rb;
                        Reg_Enable <= Ra;
                        AddSub_Select <= '0'; -- add
        
                    when "01" =>  -- NEG
                        MUX_A_Select <= "000"; -- R0 (zero)
                        MUX_B_Select <= Ra;
                        Reg_Enable <= Ra;
                        AddSub_Select <= '1'; -- subtract
        
                    when "11" =>  -- JZR
                        if Reg_Check_Zero = "0000" then
                            Jump_Flag <= '1';
                        end if;
                        -- Jump_Address is already assigned
                        -- Reg_Check_Zero = Ra (used to feed the MUX to ALU for zero checking)
        
                    when others =>
                        null;
                end case;
            end process;
        end Behavioral;



