library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Instruction_Decoder is
end tb_Instruction_Decoder;

architecture Behavioral of tb_Instruction_Decoder is

    -- Component declaration
    component Instruction_Decoder
        Port (
            Instruction     : in  STD_LOGIC_VECTOR(12 downto 0);
            Reg_Check_Zero  : in  STD_LOGIC_VECTOR(3 downto 0);
            Reg_Enable      : out STD_LOGIC_VECTOR(2 downto 0);
            Load_Select     : out STD_LOGIC;
            Immediate       : out STD_LOGIC_VECTOR(3 downto 0);
            MUX_A_Select    : out STD_LOGIC_VECTOR(2 downto 0);
            MUX_B_Select    : out STD_LOGIC_VECTOR(2 downto 0);
            AddSub_Select   : out STD_LOGIC;
            Jump_Flag       : out STD_LOGIC;
            Jump_Address    : out STD_LOGIC_VECTOR(2 downto 0);
            Bit_Select      : out STD_LOGIC_VECTOR(1 downto 0);
            Mode            : out STD_LOGIC
        );
    end component;

    -- Signals for inputs
    signal Instruction     : STD_LOGIC_VECTOR(12 downto 0) := (others => '0');
    signal Reg_Check_Zero  : STD_LOGIC_VECTOR(3 downto 0) := "0000";

    -- Signals for outputs
    signal Reg_Enable      : STD_LOGIC_VECTOR(2 downto 0);
    signal Load_Select     : STD_LOGIC;
    signal Immediate       : STD_LOGIC_VECTOR(3 downto 0);
    signal MUX_A_Select    : STD_LOGIC_VECTOR(2 downto 0);
    signal MUX_B_Select    : STD_LOGIC_VECTOR(2 downto 0);
    signal AddSub_Select   : STD_LOGIC;
    signal Jump_Flag       : STD_LOGIC;
    signal Jump_Address    : STD_LOGIC_VECTOR(2 downto 0);
    signal Bit_Select      : STD_LOGIC_VECTOR(1 downto 0);
    signal Mode            : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Instruction_Decoder
        Port Map (
            Instruction     => Instruction,
            Reg_Check_Zero  => Reg_Check_Zero,
            Reg_Enable      => Reg_Enable,
            Load_Select     => Load_Select,
            Immediate       => Immediate,
            MUX_A_Select    => MUX_A_Select,
            MUX_B_Select    => MUX_B_Select,
            AddSub_Select   => AddSub_Select,
            Jump_Flag       => Jump_Flag,
            Jump_Address    => Jump_Address,
            Bit_Select      => Bit_Select,
            Mode            => Mode
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- MOVI R1, 4 (opcode=010, Reg=001, imm=0100)
        Instruction <= "0100010000100";
        wait for 10 ns;

        -- ADD R2, R1 (opcode=000, Reg=010, Rb=001)
        Instruction <= "0000100010000";
        wait for 10 ns;

        -- NEG R3 (opcode=001, Reg=011)
        Instruction <= "0010110000000";
        wait for 10 ns;

        -- JZR R4, address 3 (opcode=011, Reg=100, addr=011)
        Instruction <= "0111000000011";
        Reg_Check_Zero <= "0000";  -- should trigger jump
        wait for 10 ns;

        -- Bitwise NOT R5 (opcode=100, Reg=101)
        Instruction <= "1001010000000";
        wait for 10 ns;

        -- Bitwise AND R6, R7 (opcode=101, Ra=110, Rb=111)
        Instruction <= "1011101110000";
        wait for 10 ns;

        -- Bitwise OR R1, R2 (opcode=110, Ra=001, Rb=010)
        Instruction <= "1100010100000";
        wait for 10 ns;

        -- Bitwise XOR R3, R4 (opcode=111, Ra=011, Rb=100)
        Instruction <= "1110111000000";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
