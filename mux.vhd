library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX is
    Port ( S : in  STD_LOGIC_VECTOR (2 downto 0);
           I : in  STD_LOGIC_VECTOR (7 downto 0);
           Y : out STD_LOGIC);

end MUX;

architecture Behavioral of MUX is

begin

process (S,I)
begin

if (S <= "000") then
Y <= I(0);
elsif (S <= "001") then
Y <= I(1);
elsif (S <= "010") then
Y <= I(2);
elsif (S <= "011") then
Y <= I(3);
elsif (S <= "100") then
Y <= I(4);
elsif (S <= "101") then
Y <= I(5);
elsif (S <= "110") then
Y <= I(6);
else
Y <= I(7);
end if;

end process;
end Behavioral;