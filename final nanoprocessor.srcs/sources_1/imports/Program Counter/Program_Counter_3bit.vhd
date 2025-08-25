library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_Counter_3bit is
    Port (
        Mux_out : in  STD_LOGIC_VECTOR(2 downto 0);  -- Next PC value
        Clk     : in  STD_LOGIC;
        Res     : in  STD_LOGIC;
        Q       : out STD_LOGIC_VECTOR(2 downto 0)  -- Current PC value
       -- Qbar    : out STD_LOGIC_VECTOR(2 downto 0)   -- Inverted PC value
    );
end Program_Counter_3bit;

architecture Behavioral of Program_Counter_3bit is
    signal PC : STD_LOGIC_VECTOR(2 downto 0) := "000";
begin

    process(Clk, Res)
    begin
        if rising_edge(Clk) then
              if Res = '1' then
                 PC <= "000";
              else
                 PC <= Mux_out;
              end if; 
        end if;
    end process;

    Q    <= PC;
   -- Qbar <= not PC;

end Behavioral;
