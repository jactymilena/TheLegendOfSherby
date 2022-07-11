----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.07.2022 12:14:45
-- Design Name: 
-- Module Name: tileBgBuffer - Behavioral
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

entity tileBgBuffer is
    Port ( 
--            clk : in std_ulogic;
            pixel_X : in STD_LOGIC_VECTOR (3 downto 0);
            pixel_Y : in STD_LOGIC_VECTOR (3 downto 0);
            tileId : in STD_LOGIC_VECTOR (7 downto 0);
           colorCode : out STD_LOGIC_VECTOR (3 downto 0));
           
end tileBgBuffer;

architecture Behavioral of tileBgBuffer is
type Tuiles256 is array(0 to 255) of std_logic_vector(1023 downto 0);
--signal tabcc : ccTile;
signal remplirCC, tuileCC : STD_LOGIC_VECTOR (1023 downto 0);
--component tile is
--    Port ( 
--            pixel_X : in STD_LOGIC_VECTOR (3 downto 0);
--            pixel_Y : in STD_LOGIC_VECTOR (3 downto 0);
--            tileId : in STD_LOGIC_VECTOR (7 downto 0);
--           RE : in std_logic ;    
--           inColorCode: in STD_LOGIC_VECTOR (63 downto 0);
--           outColorCode : out STD_LOGIC_VECTOR (3 downto 0));
--end component;


signal TuilesMemory : Tuiles256 := (
-- 256 tuiles de background
X"9999999999999999", -- gazon vert buisson tuile 0
X"cccccccccccccccc",-- chemin jaune tuile 1
X"3333333333333333", -- eau bleu pale tuile 2
X"4444444444444444", -- rouge tuile 3
X"5555555555555555", -- rose  tuile 4
X"6666666666666666", -- beige tuile 5
X"7777777777777777", -- Lime tuile 6
X"8888888888888888", -- vert foret tuile 7
X"aaaaaaaaaaaaaaaa", -- Brun tuile 8
X"dddddddddddddddd", -- Gris tuile 9
X"eeeeeeeeeeeeeeee", -- Bleu foncé tuile 10



others => X"000000000000000");

begin

--process( clk )
--    begin
--        if clk='1' and clk'event then
        tuileCC <= TuilesMemory(to_integer(unsigned(tileId)));
        colorCode <= tuileCC((to_integer((unsigned(pixel_Y) *64) + (unsigned(pixel_X)*4))+3) downto to_integer((unsigned(pixel_Y) *64)+ (unsigned(pixel_X)*4)));
--        end if;

--end process; 
--tile0: tile  Port map (
----pixel_X => pixel_X,
----pixel_Y => pixel_Y,
--tileId => X"00"
----inColorCode => remplirCC,
----outColorCode => colorCode
--);

end Behavioral;
