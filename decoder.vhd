library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decode_2to4_top is
    Port ( A  : in  STD_LOGIC_VECTOR (1 downto 0);  -- 2-bit input
           X  : out STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit output
           EN : in  STD_LOGIC);                     -- enable input
end decode_2to4_top;

architecture Behavioral of decode_2to4_top is
begin
process (A, EN)
begin
    --X <= "0000";        -- default output value
    if (EN = '1') then  -- active high enable pin
        case A is
            when "00" => X <= "0001";
            when "01" => X <= "0010";
            when "10" => X <= "0100";
            when "11" => X <= "1000";
			
            when others => X <= "0000";
        end case;
    end if;
end process;

end Behavioral;