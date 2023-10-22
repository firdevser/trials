

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 

entity countDisplay is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           upButton : in STD_LOGIC;
           selectedAnode: out STD_LOGIC_VECTOR (3 downto 0);
           displaySevenSegment : out STD_LOGIC_VECTOR (6 downto 0));
end countDisplay;

architecture Behavioral of countDisplay is

signal refresh_rate: STD_LOGIC_VECTOR (1 downto 0);
signal binary_coded_decimal: STD_LOGIC_VECTOR (3 downto 0);
signal display_number: STD_LOGIC_VECTOR (15 downto 0);
signal clk_divider: STD_LOGIC_VECTOR(22 downto 0);
signal slow_clk: STD_LOGIC;
begin

Clock_Divider:process(reset,clk)
begin
    if(reset='1') then
        clk_divider   <= (others=>'0');
    elsif(clk'event and clk='1') then
        clk_divider   <= clk_divider + 1;
  end if;    
end process;
slow_clk<= clk_divider(22);
refresh_rate<= clk_divider(20 downto 19);

BCD_Counter:process(reset,slow_clk)
begin
    if(reset='1') then
        display_number <= (others => '0');
    elsif(slow_clk'event and slow_clk='1') then
        if (upButton='1') then
            if(display_number(3 downto 0)>=9) then
                display_number(3 downto 0) <= "0000";
                display_number(7 downto 4) <= display_number(7 downto 4)+ "0001";
                if (display_number(7 downto 4)>=9) then
                    display_number(7 downto 0) <= "00000000";
                    display_number(11 downto 8) <= display_number(11 downto 8)+ "0001";
                    if (display_number(11 downto 8)>=9) then
                        display_number(11 downto 0) <= "000000000000";
                        display_number(15 downto 12) <= display_number(15 downto 12)+ "0001";
                        if (display_number(15 downto 12)>=9)then
                            display_number(15 downto 0) <= "0000000000000000";
                end if;
                end if;
                end if;
            else
                display_number(3 downto 0) <= display_number(3 downto 0) + "0000";
            end if;
        else
            display_number <= display_number;
        end if; 
    end if;

end process;

Anode_Selection:process(refresh_rate)
begin
    case refresh_rate is
        when "00" => selectedAnode <= "0111";
                     binary_coded_decimal<=display_number(15 downto 12);
        when "01" => selectedAnode <= "1011";
                     binary_coded_decimal<=display_number(11 downto 8);
        when "10" => selectedAnode <= "1101";
                     binary_coded_decimal<=display_number(7 downto 4);
        when "11" => selectedAnode <= "1110";
                     binary_coded_decimal<=display_number(3 downto 0);   
    end case;
end process;

Segment_Display_Decoder:process(binary_coded_decimal)
begin
    case binary_coded_decimal is
        when "0000" => displaySevenSegment <= "0000001";      
        when "0001" => displaySevenSegment <= "1001111";  
        when "0010" => displaySevenSegment <= "0010010";  
        when "0011" => displaySevenSegment <= "0000110";  
        when "0100" => displaySevenSegment <= "1001100";  
        when "0101" => displaySevenSegment <= "0100100";  
        when "0110" => displaySevenSegment <= "0100000";  
        when "0111" => displaySevenSegment <= "0001111";  
        when "1000" => displaySevenSegment <= "0000000";      
        when "1001" => displaySevenSegment <= "0000100";
        when others => displaySevenSegment <= "1111111";
    end case;       
end process;    

end Behavioral;
