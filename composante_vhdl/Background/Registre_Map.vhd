----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.07.2022 15:00:52
-- Design Name: 
-- Module Name: Registre_Map - Behavioral
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
use work.tuile_package.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Registre_Map is
    Port ( setMap : in STD_LOGIC_VECTOR (3 downto 0);
--           addMap : in RegistreTileId;
--           indexMap : in STD_LOGIC_VECTOR (4 downto 0);
           map_Enable: in STD_LOGIC;
           Background : out RegistreTileId);
end Registre_Map;

architecture Behavioral of Registre_Map is
type RegistreMap is array (0 to 15) of RegistreTileId;
signal tableauMap : RegistreMap := (
(others => (others => x"01")),
(others => (others => x"02")),
(others => (others => x"03")),
(others => (others => x"04")),
others => (others=> (others => x"00")));

begin
process
begin 
if(map_Enable = '1') then 
    Background <= tableauMap(to_integer(unsigned(setMap)));
    end if;

end process;

end Behavioral;
