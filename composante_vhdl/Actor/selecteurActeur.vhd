----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.07.2022 15:16:33
-- Design Name: 
-- Module Name: selecteurActeur - Behavioral
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

entity selecteurActeur is
    Port ( hits : in STD_LOGIC_VECTOR (11 downto 0) := "000000000000" ;
           ActorId : out STD_LOGIC_VECTOR (3 downto 0));
end selecteurActeur;

architecture Behavioral of selecteurActeur is
--type tabActeur is array (0 to 11) of std_logic_vector(7 downto 0);
--signal tile : tabActeur := ( tileId_a0, tileId_a1, 
--);
begin
ActorId <= x"0" when (hits and x"001") = "000000000001" else
           x"1" when (hits and x"002") = "000000000010" else
           x"2" when (hits and x"004") = "000000000100" else
           x"3" when (hits and x"008") = "000000001000" else
           x"4" when (hits and x"010") = "000000010000" else
           x"5" when (hits and x"020") = "000000100000" else
           x"6" when (hits and x"040") = "000001000000" else
           x"7" when (hits and x"080") = "000010000000" else
           x"8" when (hits and x"100") = "000100000000" else
           x"9" when (hits and x"200") = "001000000000" else
           x"a" when (hits and x"400") = "010000000000" else
           x"b" when (hits and x"800") = "100000000000" else
           x"c";

end Behavioral;
